#include "intercept.hpp"
#include "navigation.hpp"
#include "utility.hpp"
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

    // ai_nav_findNearestNode: Find nearest navigation node to position
    // Params: [position[x,y,z], maxDistance (default 50)]
    // Returns: nodeId or -1 if not found
    DLLEXPORT void CDECL ai_nav_findNearestNode_native(game_value_parameter ctx)
    {
        try {
            auto& args = ctx.get_as<game_data_array>().getRef()->data;
            if (args.size() < 1) {
                rv_utility::setSignalReturn(-1);
                return;
            }

            // Parse position
            auto& pos_data = args[0].get_as<game_data_array>().getRef()->data;
            std::vector<float> search_pos = {
                static_cast<float>(pos_data[0]),
                static_cast<float>(pos_data[1]),
                static_cast<float>(pos_data[2])
            };

            float max_distance = (args.size() > 1) ? static_cast<float>(args[1]) : 50.0f;

            // Call navigation module function
            int result = rv_navigation::findNearestNode(search_pos, max_distance);
            
            // Set return value using utility function
            rv_utility::setSignalReturn(result);
        }
        catch (const std::exception& e) {
            std::cerr << "ai_nav_findNearestNode_native error: " << e.what() << std::endl;
            rv_utility::setSignalReturn(-1);
        }
    }

    // ai_nav_findPathToClosestNode: A* pathfinding to closest node near target position
    // Params: [startNodeId, targetPos[x,y,z], earlyExitDistance (default 2)]
    // Returns: array of nodeIds (path)
    DLLEXPORT void CDECL ai_nav_findPathToClosestNode_native(game_value_parameter ctx)
    {
        try {
            auto& args = ctx.get_as<game_data_array>().getRef()->data;
            if (args.size() < 2) {
                rv_utility::setSignalReturn(std::vector<game_value>{});
                return;
            }

            int start_node_id = static_cast<int>(args[0]);
            
            auto& target_pos_data = args[1].get_as<game_data_array>().getRef()->data;
            std::vector<float> target_pos = {
                static_cast<float>(target_pos_data[0]),
                static_cast<float>(target_pos_data[1]),
                static_cast<float>(target_pos_data[2])
            };

            float early_exit_dist = (args.size() > 2) ? static_cast<float>(args[2]) : 2.0f;

            // Call navigation module function
            std::vector<int> path = rv_navigation::findPathToClosestNode(start_node_id, target_pos, early_exit_dist);
            
            // Set return value using utility function
            rv_utility::setSignalReturn(path);
        }
        catch (const std::exception& e) {
            std::cerr << "ai_nav_findPathToClosestNode_native error: " << e.what() << std::endl;
            rv_utility::setSignalReturn(std::vector<game_value>{});
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
            if (args.size() < 2) {
                rv_utility::setSignalReturn(std::vector<game_value>{});
                return;
            }

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

            // Call navigation module function with optional out parameter
            std::vector<int> path_nodes;
            std::vector<std::vector<float>> path_positions = rv_navigation::findPartialPath(
                start_pos,
                end_pos,
                optimize,
                &path_nodes
            );

            // Handle refPathNodes OUT parameter (4th param) - write path node IDs array as first element
            if (args.size() > 3 && !args[3].is_nil() && !path_nodes.empty()) {
                try {
                    // args[3] is a reference wrapper array [[]]
                    // We need to put the path_nodes array as the FIRST element
                    auto& ref_wrapper_data = args[3].get_as<game_data_array>().getRef()->data;
                    ref_wrapper_data.clear();
                    
                    // Convert path_nodes to game_value array
                    std::vector<game_value> gv_path_nodes;
                    for (int node_id : path_nodes) {
                        gv_path_nodes.push_back(game_value(node_id));
                    }
                    
                    // Push the entire path_nodes array as the first element of wrapper
                    ref_wrapper_data.push_back(game_value(gv_path_nodes));
                }
                catch (const std::exception& e) {
                    std::cerr << "Warning: Failed to set refPathNodes: " << e.what() << std::endl;
                }
            }

            // Set return value using utility function
            rv_utility::setSignalReturn(path_positions);
        }
        catch (const std::exception& e) {
            std::cerr << "ai_nav_findPartialPath_native error: " << e.what() << std::endl;
            rv_utility::setSignalReturn(std::vector<game_value>{});
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
