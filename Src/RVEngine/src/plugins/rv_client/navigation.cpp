#include "navigation.hpp"
#include <cmath>
#include <algorithm>
#include <queue>
#include <iostream>

namespace rv_navigation {

    // ============================================================================
    // HELPER FUNCTIONS
    // ============================================================================

    std::string calculate_region_key_string(float x, float y, float region_size) {
        int rx = static_cast<int>(std::floor(x / region_size));
        int ry = static_cast<int>(std::floor(y / region_size));
        return std::to_string(rx) + "_" + std::to_string(ry);
    }

    float distance3d(const std::vector<float>& p1, const std::vector<float>& p2) {
        float dx = p1[0] - p2[0];
        float dy = p1[1] - p2[1];
        float dz = p1[2] - p2[2];
        return std::sqrt(dx * dx + dy * dy + dz * dz);
    }

    std::vector<float> get_node_position(const game_value& node_data) {
        try {
            // Check if node_data is valid
            if (node_data.is_nil()) {
                return {0, 0, 0};
            }

            // Access hashmap data and get "pos" key
            auto* hashmap_ref = node_data.get_as<game_data_hashmap>().getRef();
            if (!hashmap_ref) {
                return {0, 0, 0};
            }

            auto& hashmap_data = hashmap_ref->data;
            auto* pos_pair = hashmap_data.find(game_value("pos"));
            if (!pos_pair) {
                return {0, 0, 0};
            }

            auto pos_array = pos_pair->value;
            if (pos_array.is_nil()) {
                return {0, 0, 0};
            }

            auto* array_ref = pos_array.get_as<game_data_array>().getRef();
            if (!array_ref) {
                return {0, 0, 0};
            }

            auto& pos_data = array_ref->data;
            if (pos_data.size() < 3) {
                return {0, 0, 0};
            }

            return {
                static_cast<float>(pos_data[0]),
                static_cast<float>(pos_data[1]),
                static_cast<float>(pos_data[2])
            };
        }
        catch (const std::exception& e) {
            std::cerr << "get_node_position error: " << e.what() << std::endl;
            return {0, 0, 0};
        }
        catch (...) {
            std::cerr << "get_node_position: unknown error" << std::endl;
            return {0, 0, 0};
        }
    }

    // ============================================================================
    // CORE NAVIGATION FUNCTIONS
    // ============================================================================

    int findNearestNode(const std::vector<float>& search_pos, float max_distance) {
        try {
            // Get global data from mission namespace
            auto ns = intercept::sqf::mission_namespace();
            auto regions = intercept::sqf::get_variable(ns, "ai_nav_regions");
            auto nodes = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto region_size = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_regionSize"));

            if (regions.is_nil() || nodes.is_nil()) {
                return -1;
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
                return best_node;
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
                                    if (dist < 0.5f) return best_node; // Early exit
                                }
                            }
                        }
                    }
                }
            }

            return best_node;
        }
        catch (const std::exception& e) {
            std::cerr << "findNearestNode error: " << e.what() << std::endl;
            return -1;
        }
    }

    std::vector<int> findPathToClosestNode(
        int start_node_id,
        const std::vector<float>& target_pos,
        float early_exit_dist
    ) {
        try {
            // Get global data
            auto ns = intercept::sqf::mission_namespace();
            auto nodes = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto adjacency = intercept::sqf::get_variable(ns, "ai_nav_adjacency");

            if (nodes.is_nil() || adjacency.is_nil() || start_node_id == -1) {
                return {};
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
                return {};
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
            std::vector<int> path;
            int current = closest_node;
            path.push_back(current);

            while (came_from.find(current) != came_from.end()) {
                current = came_from[current];
                path.push_back(current);
            }

            std::reverse(path.begin(), path.end());

            return path;
        }
        catch (const std::exception& e) {
            std::cerr << "findPathToClosestNode error: " << e.what() << std::endl;
            return {};
        }
    }

    std::vector<std::vector<float>> findPartialPath(
        const std::vector<float>& start_pos,
        const std::vector<float>& end_pos,
        bool optimize,
        std::vector<int>* out_path_nodes
    ) {
        try {
            auto ns = intercept::sqf::mission_namespace();
            
            // Find start node
            int start_node = findNearestNode(start_pos);

            if (start_node == -1) {
                return {};
            }

            // Find path to closest node near end position
            auto path_nodes = findPathToClosestNode(start_node, end_pos, 2.0f);

            if (path_nodes.empty()) {
                return {};
            }
            
            // Store path nodes if requested
            if (out_path_nodes != nullptr) {
                *out_path_nodes = path_nodes;
            }

            // Convert node IDs to positions
            auto nodes = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto& nodes_data = nodes.get_as<game_data_hashmap>().getRef()->data;

            std::vector<std::vector<float>> path_positions;
            for (int node_id : path_nodes) {
                auto* node_pair = nodes_data.find(game_value(node_id));
                if (node_pair) {
                    auto node_pos = get_node_position(node_pair->value);
                    path_positions.push_back(node_pos);
                }
            }

            // Apply path smoothing if requested
            if (optimize && path_positions.size() > 2) {
                return smoothPathAggressive(path_positions);
            }

            return path_positions;
        }
        catch (const std::exception& e) {
            std::cerr << "findPartialPath error: " << e.what() << std::endl;
            return {};
        }
    }

    // ============================================================================
    // PATH SMOOTHING FUNCTIONS
    // ============================================================================

    std::vector<std::vector<float>> smoothPathFast(const std::vector<std::vector<float>>& path) {
        if (path.size() < 3) return path;

        std::vector<std::vector<float>> result;
        result.push_back(path[0]);

        for (size_t i = 1; i < path.size() - 1; ++i) {
            // Calculate vectors
            std::vector<float> v1 = {
                path[i][0] - path[i-1][0],
                path[i][1] - path[i-1][1],
                path[i][2] - path[i-1][2]
            };
            
            std::vector<float> v2 = {
                path[i+1][0] - path[i][0],
                path[i+1][1] - path[i][1],
                path[i+1][2] - path[i][2]
            };

            // Cross product magnitude (to detect turns)
            float cross_mag = std::abs(v1[0] * v2[1] - v1[1] * v2[0]);

            // If vectors are not co-directional - it's a turn
            if (cross_mag > 0.1f) {
                result.push_back(path[i]);
            }
        }

        result.push_back(path[path.size() - 1]);
        return result;
    }

    std::vector<std::vector<float>> smoothPathAggressive(
        const std::vector<std::vector<float>>& path,
        float angle_threshold_deg
    ) {
        if (path.size() < 3) return path;

        std::vector<std::vector<float>> result;
        result.push_back(path[0]);

        for (size_t i = 1; i < path.size() - 1; ++i) {
            auto& prev = path[i - 1];
            auto& curr = path[i];
            auto& next = path[i + 1];

            std::vector<float> v1 = {
                curr[0] - prev[0],
                curr[1] - prev[1],
                curr[2] - prev[2]
            };
            
            std::vector<float> v2 = {
                next[0] - curr[0],
                next[1] - curr[1],
                next[2] - curr[2]
            };

            // Calculate vector magnitudes
            float len1 = std::sqrt(v1[0]*v1[0] + v1[1]*v1[1] + v1[2]*v1[2]);
            float len2 = std::sqrt(v2[0]*v2[0] + v2[1]*v2[1] + v2[2]*v2[2]);

            if (len1 > 0.1f && len2 > 0.1f) {
                // Calculate angle between vectors using dot product
                float dot = v1[0]*v2[0] + v1[1]*v2[1] + v1[2]*v2[2];
                float cos_angle = std::max(-1.0f, std::min(1.0f, dot / (len1 * len2)));
                float angle_rad = std::acos(cos_angle);
                float angle_deg = angle_rad * 180.0f / 3.14159265f;

                // Keep point only if angle exceeds threshold
                if (angle_deg > angle_threshold_deg) {
                    result.push_back(curr);
                }
            }
        }

        result.push_back(path[path.size() - 1]);
        return result;
    }

    bool hasLineOfSight(const std::vector<float>& pos1, const std::vector<float>& pos2) {
        try {
            // Create game_value arrays for positions
            std::vector<game_value> gv_pos1 = {
                game_value(pos1[0]),
                game_value(pos1[1]),
                game_value(pos1[2] + 0.4f)  // Add height offset
            };
            
            std::vector<game_value> gv_pos2 = {
                game_value(pos2[0]),
                game_value(pos2[1]),
                game_value(pos2[2] + 0.4f)  // Add height offset
            };

            // Use lineIntersectsSurfaces to check for obstacles
            // This is a simplified version - in real implementation you'd need to call SQF function
            // For now, we'll use a simplified approach
            
            // Calculate distance
            float dist = distance3d(pos1, pos2);
            
            // For very short distances, assume line of sight
            if (dist < 2.0f) return true;
            
            // For longer distances, we need actual terrain check
            // This would require calling SQF's lineIntersectsSurfaces
            // For now, return false to be conservative
            return false;
        }
        catch (const std::exception& e) {
            std::cerr << "hasLineOfSight error: " << e.what() << std::endl;
            return false;
        }
    }

    std::vector<std::vector<float>> smoothPathLineOfSight(const std::vector<std::vector<float>>& path) {
        if (path.size() < 3) return path;

        std::vector<std::vector<float>> smooth_path;
        smooth_path.push_back(path[0]); // Start point

        size_t current_idx = 0;

        while (current_idx < path.size() - 1) {
            auto& from_pos = path[current_idx];
            size_t farthest_idx = current_idx + 1;

            // Find farthest point with line of sight
            for (size_t i = current_idx + 2; i < path.size(); ++i) {
                auto& to_pos = path[i];
                
                if (hasLineOfSight(from_pos, to_pos)) {
                    farthest_idx = i;
                } else {
                    break; // Obstacle found, stop checking
                }
            }

            // Add farthest accessible point
            smooth_path.push_back(path[farthest_idx]);
            current_idx = farthest_idx;
        }

        return smooth_path;
    }

} // namespace rv_navigation

