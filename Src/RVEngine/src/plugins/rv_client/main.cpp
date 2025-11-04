#include "intercept.hpp"
#include <Windows.h>
#include <string>
#include <vector>
#include <unordered_map>
#include <queue>
#include <cmath>
#include <algorithm>

using namespace intercept;

// Required exported function to return API version
extern "C" {
    DLLEXPORT int CDECL api_version() {
        return INTERCEPT_SDK_API_VERSION;
    }

    // Optional lifecycle hooks
    DLLEXPORT void CDECL pre_start() {

    }

    DLLEXPORT void CDECL post_start() {
        // Called at CBA XEH_preStart
    }

    DLLEXPORT void CDECL pre_pre_init() {
        // Called before pre_init
    }

    DLLEXPORT void CDECL pre_init() {
        // Called at CBA XEH_preInit
    }

    DLLEXPORT void CDECL post_init() {
        // Called at CBA XEH_postInit
    }

    DLLEXPORT void CDECL mission_ended() {
        // Called when mission ends
    }

    // Called each frame
    DLLEXPORT void CDECL on_frame() {
        // Your frame logic here
        float tick = intercept::sqf::diag_ticktime();
        object p = intercept::sqf::player();
        intercept::sqf::set_variable(p, "testvar", tick);
    }

    DLLEXPORT void CDECL on_signal(std::string& signal_name_, game_value& value1_) {
        // Handle signals
        std::cout << "Signal received: " << signal_name_ << std::endl;
        std::cout << "Signal parameters: " << std::string(value1_) << std::endl;
        if(signal_name_ == "testsignal") {
            sqf::set_variable(intercept::sqf::mission_namespace(), "sigret", value1_);
        }
    }
    DLLEXPORT void CDECL testsignal(game_value_parameter ctx)
    {
        std::cout << "Signal received: " << std::string(ctx) << std::endl;
        std::cout << "Signal parameters: " << std::string(ctx) << std::endl;
        auto& first = ctx.get_as<game_data_array>().getRef()->data[0];
        sqf::set_variable(intercept::sqf::mission_namespace(), "sigret", first);
    }

    DLLEXPORT void CDECL on_interface_unload(r_string name_) {
        // Handle interface unload
    }

    intercept::types::registered_sqf_function _unary_func_example; //Return value of register_sqf_command has to be stored for the lifetime of the registered function
    std::unordered_map<uintptr_t, game_value> proto_cache;
    game_value test_binary_fnc (game_value_parameter left_arg,game_value_parameter right_arg) {
        auto& v = right_arg.get_as<game_data_array>()->data;
    
        static auto getVariable_func = intercept::client::host::functions.get_binary_function_typed(
            "getvariable", "LOCATION", "STRING"
        );
        static auto call_func = intercept::client::host::functions.get_binary_function_typed(
            "call", "ANY", "CODE"
        );
    
        // ОДИН РАЗ БЛОКИРУЕМ для всех трех вызовов
        intercept::client::host::functions.invoker_lock();
    
        game_value proto = intercept::client::host::functions.invoke_raw_binary(
            getVariable_func, left_arg, game_value("proto")
        );
    
        game_value funcCode;
        if (!proto.is_nil()) {
            auto funcName = v[0].get_as<game_data_string>();
            funcCode = intercept::client::host::functions.invoke_raw_binary(
                getVariable_func, proto, game_value(funcName->raw_string)
            );
        }
    
        game_value result;
        if (!funcCode.is_nil()) {
            result = intercept::client::host::functions.invoke_raw_binary(
                call_func, v[1], funcCode
            );
        }
    
        intercept::client::host::functions.invoker_unlock();
    
        return result;
    }
    DLLEXPORT void CDECL register_interfaces() {
         _unary_func_example = intercept::client::host::register_sqf_command(
            "testun",
            "Description not provided",
            userFunctionWrapper<test_binary_fnc>,
            intercept::types::GameDataType::ANY, //Return type
            intercept::types::GameDataType::LOCATION, //left
             intercept::types::GameDataType::ARRAY); //Right Argument Type
    }

    DLLEXPORT void CDECL handle_unload() {
        // Cleanup before unload
        _unary_func_example = intercept::types::registered_sqf_function(); // Присваиваем пустой объект
    }

    DLLEXPORT bool CDECL is_signed() {
        return false; // Set to true if your plugin is signed
    }

    // ============================================================================
    // AI NAVIGATION OPTIMIZED FUNCTIONS
    // ============================================================================

    // Helper: Calculate region key string from position
    inline std::string calculate_region_key_string(float x, float y, float region_size = 10.0f) {
        int rx = static_cast<int>(std::floor(x / region_size));
        int ry = static_cast<int>(std::floor(y / region_size));
        return std::to_string(rx) + "_" + std::to_string(ry);
    }

    // Helper: Calculate distance between two 3D points
    inline float distance3d(const std::vector<float>& p1, const std::vector<float>& p2) {
        float dx = p1[0] - p2[0];
        float dy = p1[1] - p2[1];
        float dz = p1[2] - p2[2];
        return std::sqrt(dx * dx + dy * dy + dz * dz);
    }

    // Helper: Get position from node data (game_value)
    inline std::vector<float> get_node_position(const game_value& node_data) {
        // Access hashmap data and get "pos" key
        auto& hashmap_data = node_data.get_as<game_data_hashmap>().getRef()->data;
        auto pos_array = hashmap_data[game_value("pos")];
        auto& pos_data = pos_array.get_as<game_data_array>().getRef()->data;
        return {
            static_cast<float>(pos_data[0]),
            static_cast<float>(pos_data[1]),
            static_cast<float>(pos_data[2])
        };
    }

    // ai_nav_findNearestNode: Find nearest navigation node to position
    // Params: [position[x,y,z], maxDistance (default 50)]
    // Returns: nodeId or -1 if not found
    DLLEXPORT void CDECL ai_nav_findNearestNode_native(game_value_parameter ctx)
    {
        try {
            auto& args = ctx.get_as<game_data_array>().getRef()->data;
            if (args.size() < 1) return;

            // Parse position
            auto& pos_data = args[0].get_as<game_data_array>().getRef()->data;
            std::vector<float> search_pos = {
                static_cast<float>(pos_data[0]),
                static_cast<float>(pos_data[1]),
                static_cast<float>(pos_data[2])
            };

            float max_distance = (args.size() > 1) ? static_cast<float>(args[1]) : 50.0f;

            // Get global data from mission namespace
            auto ns = intercept::sqf::mission_namespace();
            auto regions = intercept::sqf::get_variable(ns, "ai_nav_regions");
            auto nodes = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto region_size = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_regionSize"));

            if (regions.is_nil() || nodes.is_nil()) {
                sqf::set_variable(ns, "rve_sigret", -1);
                return;
            }

            // Get region key
            std::string region_key_str = calculate_region_key_string(search_pos[0], search_pos[1], region_size);

            int best_node = -1;
            float best_dist = 999999.0f;

            // Get references to hashmap data
            auto& regions_data = regions.get_as<game_data_hashmap>().getRef()->data;
            auto& nodes_data = nodes.get_as<game_data_hashmap>().getRef()->data;

            // Check current region first
            auto* region_pair = regions_data.find(game_value(region_key_str));
            if (region_pair) {
                auto& region_data_gv = region_pair->value;
                auto& region_hashmap = region_data_gv.get_as<game_data_hashmap>().getRef()->data;
                
                auto* nodes_pair = region_hashmap.find(game_value("nodes"));
                if (nodes_pair) {
                    auto& node_ids_gv = nodes_pair->value;
                    auto& node_ids = node_ids_gv.get_as<game_data_array>().getRef()->data;
                    
                    for (const auto& node_id_gv : node_ids) {
                        int node_id = static_cast<int>(node_id_gv);
                        
                        auto* node_pair = nodes_data.find(game_value(node_id));
                        if (node_pair) {
                            auto node_pos = get_node_position(node_pair->value);
                            float dist = distance3d(search_pos, node_pos);
                            
                            if (dist < best_dist && dist <= max_distance) {
                                best_dist = dist;
                                best_node = node_id;
                                if (dist < 0.5f) break; // Early exit
                            }
                        }
                    }
                }
            }

            // If found close enough, return
            if (best_node != -1 && best_dist < 0.5f) {
                sqf::set_variable(ns, "rve_sigret", best_node);
                return;
            }

            // Search in 8 neighboring regions
            std::string::size_type sep_pos = region_key_str.find('_');
            int rx = std::stoi(region_key_str.substr(0, sep_pos));
            int ry = std::stoi(region_key_str.substr(sep_pos + 1));

            static const int offsets[8][2] = {
                {0,1}, {0,-1}, {1,0}, {-1,0}, {1,1}, {-1,1}, {1,-1}, {-1,-1}
            };

            for (int i = 0; i < 8; ++i) {
                std::string neighbor_key_str = std::to_string(rx + offsets[i][0]) + "_" + 
                                               std::to_string(ry + offsets[i][1]);
                
                auto* neighbor_pair = regions_data.find(game_value(neighbor_key_str));
                if (neighbor_pair) {
                    auto& neighbor_data_gv = neighbor_pair->value;
                    auto& neighbor_hashmap = neighbor_data_gv.get_as<game_data_hashmap>().getRef()->data;
                    
                    auto* nodes_pair = neighbor_hashmap.find(game_value("nodes"));
                    if (nodes_pair) {
                        auto& node_ids_gv = nodes_pair->value;
                        auto& node_ids = node_ids_gv.get_as<game_data_array>().getRef()->data;
                        
                        for (const auto& node_id_gv : node_ids) {
                            int node_id = static_cast<int>(node_id_gv);
                            
                            auto* node_pair = nodes_data.find(game_value(node_id));
                            if (node_pair) {
                                auto node_pos = get_node_position(node_pair->value);
                                float dist = distance3d(search_pos, node_pos);
                                
                                if (dist < best_dist && dist <= max_distance) {
                                    best_dist = dist;
                                    best_node = node_id;
                                    if (dist < 0.5f) goto done; // Early exit from nested loops
                                }
                            }
                        }
                    }
                }
            }

        done:
            sqf::set_variable(ns, "rve_sigret", best_node);
        }
        catch (const std::exception& e) {
            std::cerr << "ai_nav_findNearestNode_native error: " << e.what() << std::endl;
            sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", -1);
        }
    }

    // ai_nav_findPathToClosestNode: A* pathfinding to closest node near target position
    // Params: [startNodeId, targetPos[x,y,z], earlyExitDistance (default 2)]
    // Returns: array of nodeIds (path)
    DLLEXPORT void CDECL ai_nav_findPathToClosestNode_native(game_value_parameter ctx)
    {
        try {
            auto& args = ctx.get_as<game_data_array>().getRef()->data;
            if (args.size() < 2) return;

            int start_node_id = static_cast<int>(args[0]);
            
            auto& target_pos_data = args[1].get_as<game_data_array>().getRef()->data;
            std::vector<float> target_pos = {
                static_cast<float>(target_pos_data[0]),
                static_cast<float>(target_pos_data[1]),
                static_cast<float>(target_pos_data[2])
            };

            float early_exit_dist = (args.size() > 2) ? static_cast<float>(args[2]) : 2.0f;

            // Get global data
            auto ns = intercept::sqf::mission_namespace();
            auto nodes = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto adjacency = intercept::sqf::get_variable(ns, "ai_nav_adjacency");

            if (nodes.is_nil() || adjacency.is_nil() || start_node_id == -1) {
                sqf::set_variable(ns, "rve_sigret", game_value(std::vector<game_value>{}));
                return;
            }

            // Get references to hashmap data
            auto& nodes_data = nodes.get_as<game_data_hashmap>().getRef()->data;
            auto& adjacency_data = adjacency.get_as<game_data_hashmap>().getRef()->data;

            // A* data structures
            std::unordered_map<int, bool> closed_set;
            std::unordered_map<int, int> came_from;
            std::unordered_map<int, float> g_score;
            std::unordered_map<int, float> f_score;

            // Priority queue: pair<f_score, node_id>
            auto cmp = [](const std::pair<float, int>& a, const std::pair<float, int>& b) {
                return a.first > b.first; // Min heap
            };
            std::priority_queue<std::pair<float, int>, std::vector<std::pair<float, int>>, decltype(cmp)> open_set(cmp);

            // Initialize start node
            auto* start_node_pair = nodes_data.find(game_value(start_node_id));
            if (!start_node_pair) {
                sqf::set_variable(ns, "rve_sigret", game_value(std::vector<game_value>{}));
                return;
            }

            auto start_pos = get_node_position(start_node_pair->value);
            float start_h = distance3d(start_pos, target_pos) * 1.3f;
            
            g_score[start_node_id] = 0.0f;
            f_score[start_node_id] = start_h;
            open_set.push({start_h, start_node_id});

            int closest_node = start_node_id;
            float closest_dist = distance3d(start_pos, target_pos);

            int iterations = 0;
            const int max_iterations = 500;

            while (!open_set.empty() && iterations < max_iterations) {
                ++iterations;

                // Adaptive early exit distance
                if (iterations > 200 && early_exit_dist < 5.0f) early_exit_dist = 5.0f;
                if (iterations > 400 && early_exit_dist < 10.0f) early_exit_dist = 10.0f;

                auto current_pair = open_set.top();
                open_set.pop();
                int current = current_pair.second;

                // Skip if already closed
                if (closed_set[current]) continue;
                closed_set[current] = true;

                // Get current node position
                auto* current_node_pair = nodes_data.find(game_value(current));
                if (!current_node_pair) continue;
                
                auto current_pos = get_node_position(current_node_pair->value);
                float dist_to_target = distance3d(current_pos, target_pos);

                // Update closest node
                if (dist_to_target < closest_dist) {
                    closest_dist = dist_to_target;
                    closest_node = current;

                    // Early exit if close enough
                    if (dist_to_target <= early_exit_dist) break;
                }

                // Get neighbors
                auto* neighbors_pair = adjacency_data.find(game_value(current));
                if (!neighbors_pair) continue;
                auto& neighbors_gv = neighbors_pair->value;

                auto& neighbors_arr = neighbors_gv.get_as<game_data_array>().getRef()->data;

                for (const auto& neighbor_gv : neighbors_arr) {
                    auto& neighbor_data = neighbor_gv.get_as<game_data_array>().getRef()->data;
                    int neighbor_id = static_cast<int>(neighbor_data[0]);
                    float edge_cost = static_cast<float>(neighbor_data[1]);

                    if (closed_set[neighbor_id]) continue;

                    float tentative_g = g_score[current] + edge_cost;

                    if (g_score.find(neighbor_id) == g_score.end() || tentative_g < g_score[neighbor_id]) {
                        came_from[neighbor_id] = current;
                        g_score[neighbor_id] = tentative_g;

                        // Heuristic: distance to target
                        auto* neighbor_node_pair = nodes_data.find(game_value(neighbor_id));
                        if (neighbor_node_pair) {
                            auto neighbor_pos = get_node_position(neighbor_node_pair->value);
                            float h = distance3d(neighbor_pos, target_pos) * 1.3f;
                            float f = tentative_g + h;
                            f_score[neighbor_id] = f;
                            open_set.push({f, neighbor_id});
                        }
                    }
                }
            }

            // Reconstruct path
            std::vector<game_value> path;
            int current = closest_node;
            path.push_back(game_value(current));

            while (came_from.find(current) != came_from.end()) {
                current = came_from[current];
                path.push_back(game_value(current));
            }

            std::reverse(path.begin(), path.end());

            sqf::set_variable(ns, "rve_sigret", game_value(path));
        }
        catch (const std::exception& e) {
            std::cerr << "ai_nav_findPathToClosestNode_native error: " << e.what() << std::endl;
            sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(std::vector<game_value>{}));
        }
    }

    // ai_nav_findPartialPath: Main pathfinding function
    // Params: [startPos[x,y,z], endPos[x,y,z], optimize (bool, default true), refPathNodes (optional)]
    // Returns: array of positions [x,y,z]
    // Note: refPathNodes is handled via global variable rve_pathNodes
    DLLEXPORT void CDECL ai_nav_findPartialPath_native(game_value_parameter ctx)
    {
        try {
            auto& args = ctx.get_as<game_data_array>().getRef()->data;
            if (args.size() < 2) return;

            // Parse positions
            auto& start_pos_data = args[0].get_as<game_data_array>().getRef()->data;
            std::vector<float> start_pos = {
                static_cast<float>(start_pos_data[0]),
                static_cast<float>(start_pos_data[1]),
                static_cast<float>(start_pos_data[2])
            };

            auto& end_pos_data = args[1].get_as<game_data_array>().getRef()->data;
            std::vector<float> end_pos = {
                static_cast<float>(end_pos_data[0]),
                static_cast<float>(end_pos_data[1]),
                static_cast<float>(end_pos_data[2])
            };

            bool optimize = (args.size() > 2) ? static_cast<bool>(args[2]) : true;
            // Note: refPathNodes (4th param) is ignored in native, handled via rve_pathNodes variable

            auto ns = intercept::sqf::mission_namespace();
            
            // Find start node using native function
            std::vector<game_value> find_start_args = {args[0]};
            ai_nav_findNearestNode_native(game_value(find_start_args));
            int start_node = static_cast<int>(intercept::sqf::get_variable(ns, "rve_sigret"));

            if (start_node == -1) {
                sqf::set_variable(ns, "rve_sigret", game_value(std::vector<game_value>{}));
                return;
            }

            // Find path to closest node near end position (use default early_exit_dist = 2)
            std::vector<game_value> path_args = {
                game_value(start_node),
                args[1],
                game_value(2.0f)  // early_exit_dist
            };
            ai_nav_findPathToClosestNode_native(game_value(path_args));
            auto path_nodes_gv = intercept::sqf::get_variable(ns, "rve_sigret");

            if (path_nodes_gv.is_nil() || path_nodes_gv.size() == 0) {
                sqf::set_variable(ns, "rve_sigret", game_value(std::vector<game_value>{}));
                return;
            }
            
            // Handle refPathNodes OUT parameter (4th param) - write path node IDs array as first element
            if (args.size() > 3 && !args[3].is_nil()) {
                try {
                    // args[3] is a reference wrapper array [[]]
                    // We need to put the path_nodes array as the FIRST element
                    auto& ref_wrapper_data = args[3].get_as<game_data_array>().getRef()->data;
                    //ref_wrapper_data[0] = path_nodes_gv;//todo check this
                    ref_wrapper_data.clear();
                    
                    // Push the entire path_nodes_gv array as the first element of wrapper
                    ref_wrapper_data.push_back(path_nodes_gv);
                }
                catch (const std::exception& e) {
                    std::cerr << "Warning: Failed to set refPathNodes: " << e.what() << std::endl;
                }
            }

            // Convert node IDs to positions
            auto nodes = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto& nodes_data = nodes.get_as<game_data_hashmap>().getRef()->data;
            auto& path_nodes = path_nodes_gv.get_as<game_data_array>().getRef()->data;

            std::vector<game_value> path_positions;
            for (const auto& node_id_gv : path_nodes) {
                int node_id = static_cast<int>(node_id_gv);
                
                auto* node_pair = nodes_data.find(game_value(node_id));
                if (node_pair) {
                    auto& node_hashmap = node_pair->value.get_as<game_data_hashmap>().getRef()->data;
                    auto* pos_pair = node_hashmap.find(game_value("pos"));
                    if (pos_pair) {
                        path_positions.push_back(pos_pair->value);
                    }
                }
            }

            // TODO: Add path smoothing if optimize == true
            // For now, return raw path

            sqf::set_variable(ns, "rve_sigret", game_value(path_positions));
        }
        catch (const std::exception& e) {
            std::cerr << "ai_nav_findPartialPath_native error: " << e.what() << std::endl;
            sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(std::vector<game_value>{}));
        }
    }

    
}

// Windows DLL entry point
BOOL APIENTRY DllMain(HMODULE hModule,
    DWORD ul_reason_for_call,
    LPVOID lpReserved) {
    switch (ul_reason_for_call) {
    case DLL_PROCESS_ATTACH:
        break;
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}
