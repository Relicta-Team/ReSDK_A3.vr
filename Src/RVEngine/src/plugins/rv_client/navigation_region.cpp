#include "navigation_region.hpp"
#include "navigation.hpp"
#include "client/pointers.hpp"
#include <cmath>
#include <algorithm>
#include <iostream>
#include <sstream>

namespace rv_navigation_region {

    // Forward declarations
    void saveRegion(
        const std::string& region_key,
        const std::vector<std::vector<float>>& nodes,
        const std::vector<std::tuple<std::vector<float>, std::vector<float>, float>>& edges
    );

    // ============================================================================
    // UTILITY FUNCTIONS
    // ============================================================================

    void parseRegionKey(const std::string& region_key, int& rx, int& ry) {
        size_t sep_pos = region_key.find('_');
        rx = std::stoi(region_key.substr(0, sep_pos));
        ry = std::stoi(region_key.substr(sep_pos + 1));
    }

    std::vector<std::string> getNeighborRegionKeys(const std::string& region_key) {
        int rx, ry;
        parseRegionKey(region_key, rx, ry);

        static const int offsets[8][2] = {
            {0, 1}, {0, -1}, {1, 0}, {-1, 0},
            {1, 1}, {-1, 1}, {1, -1}, {-1, -1}
        };

        std::vector<std::string> neighbors;
        neighbors.reserve(8);

        for (int i = 0; i < 8; ++i) {
            neighbors.push_back(
                std::to_string(rx + offsets[i][0]) + "_" + 
                std::to_string(ry + offsets[i][1])
            );
        }

        return neighbors;
    }

    void getRegionBounds(
        const std::string& region_key,
        float& min_x, float& max_x,
        float& min_y, float& max_y
    ) {
        auto ns = intercept::sqf::mission_namespace();
        float region_size = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_regionSize"));

        int rx, ry;
        parseRegionKey(region_key, rx, ry);

        min_x = rx * region_size;
        max_x = min_x + region_size;
        min_y = ry * region_size;
        max_y = min_y + region_size;
    }

    // ============================================================================
    // HELPER FUNCTIONS
    // ============================================================================

    std::vector<BorderNode> getBorderNodes(
        const std::string& region_key,
        int dx,
        int dy
    ) {
        try {
            auto ns = intercept::sqf::mission_namespace();
            auto regions = intercept::sqf::get_variable(ns, "ai_nav_regions");
            auto nodes_global = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            float region_size = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_regionSize"));
            float grid_step = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_gridStep"));

            if (regions.is_nil() || nodes_global.is_nil()) {
                return {};
            }

            auto& regions_data = regions.get_as<game_data_hashmap>().getRef()->data;
            auto* region_pair = regions_data.find(game_value(region_key));
            
            if (!region_pair) {
                return {};
            }

            auto& region_hashmap = region_pair->value.get_as<game_data_hashmap>().getRef()->data;
            auto* nodes_pair = region_hashmap.find(game_value("nodes"));
            
            if (!nodes_pair) {
                return {};
            }

            auto& node_ids = nodes_pair->value.get_as<game_data_array>().getRef()->data;
            auto& nodes_data = nodes_global.get_as<game_data_hashmap>().getRef()->data;

            // Calculate region bounds
            float min_x, max_x, min_y, max_y;
            getRegionBounds(region_key, min_x, max_x, min_y, max_y);

            float threshold = grid_step * 1.5f;

            std::vector<BorderNode> border_nodes;
            border_nodes.reserve(node_ids.size() / 4); // Estimate ~25% nodes are on border

            int index = 0;
            for (const auto& node_id_gv : node_ids) {
                int node_id = static_cast<int>(node_id_gv);
                
                auto* node_pair = nodes_data.find(game_value(node_id));
                if (!node_pair) {
                    ++index;
                    continue;
                }

                // Check if node_pair->value is valid before accessing
                if (node_pair->value.is_nil()) {
                    ++index;
                    continue;
                }

                auto node_pos = rv_navigation::get_node_position(node_pair->value);
                
                // Skip if position extraction failed (all zeros means error)
                // Note: This might skip valid nodes at origin, but it's safer than crashing
                if (node_pos[0] == 0 && node_pos[1] == 0 && node_pos[2] == 0) {
                    ++index;
                    continue;
                }

                float px = node_pos[0];
                float py = node_pos[1];

                bool is_border = false;

                // Check only needed border by direction
                if (dx == 1 && std::abs(px - max_x) < threshold) is_border = true;   // East
                if (dx == -1 && std::abs(px - min_x) < threshold) is_border = true;  // West
                if (dy == 1 && std::abs(py - max_y) < threshold) is_border = true;   // North
                if (dy == -1 && std::abs(py - min_y) < threshold) is_border = true;  // South

                if (is_border) {
                    border_nodes.push_back({node_id, index, node_pos});
                }

                ++index;
            }

            return border_nodes;
        }
        catch (const std::exception& e) {
            std::cerr << "getBorderNodes error: " << e.what() << std::endl;
            return {};
        }
    }

    std::unordered_map<std::string, std::vector<std::pair<int, std::vector<float>>>> buildSpatialGrid(
        const std::vector<BorderNode>& nodes,
        float grid_size
    ) {
        std::unordered_map<std::string, std::vector<std::pair<int, std::vector<float>>>> spatial_grid;

        for (const auto& node : nodes) {
            float px = node.position[0];
            float py = node.position[1];

            int grid_x = static_cast<int>(std::floor(px / grid_size));
            int grid_y = static_cast<int>(std::floor(py / grid_size));
            
            std::string grid_key = std::to_string(grid_x) + "," + std::to_string(grid_y);

            spatial_grid[grid_key].push_back({node.index, node.position});
        }

        return spatial_grid;
    }

    // ============================================================================
    // BATCH PROCESSING FUNCTIONS
    // ============================================================================

    // ============================================================================
    // CORE REGION UPDATE FUNCTIONS
    // ============================================================================

    std::vector<int> buildEntrancesBetween(
        const std::string& region_key1,
        const std::string& region_key2
    ) {
        try {
            auto ns = intercept::sqf::mission_namespace();
            auto regions = intercept::sqf::get_variable(ns, "ai_nav_regions");
            auto adjacency = intercept::sqf::get_variable(ns, "ai_nav_adjacency");

            if (regions.is_nil() || adjacency.is_nil()) {
                return {0, 0, 0};
            }

            auto& regions_data = regions.get_as<game_data_hashmap>().getRef()->data;
            auto& adjacency_data = adjacency.get_as<game_data_hashmap>().getRef()->data;

            // Get region data
            auto* region1_pair = regions_data.find(game_value(region_key1));
            auto* region2_pair = regions_data.find(game_value(region_key2));
            if (!region1_pair || !region2_pair) return {0, 0, 0};

            auto& region1_hashmap = region1_pair->value.get_as<game_data_hashmap>().getRef()->data;
            auto& region2_hashmap = region2_pair->value.get_as<game_data_hashmap>().getRef()->data;

            // Parse region coordinates
            int rx1, ry1, rx2, ry2;
            parseRegionKey(region_key1, rx1, ry1);
            parseRegionKey(region_key2, rx2, ry2);

            // Get border nodes
            auto border1 = getBorderNodes(region_key1, rx2 - rx1, ry2 - ry1);
            auto border2 = getBorderNodes(region_key2, rx1 - rx2, ry1 - ry2);
            if (border1.empty() || border2.empty()) return {0, 0, 0};

            // Get entrances and nodes
            auto* entrances1_pair = region1_hashmap.find(game_value("entrances"));
            auto* entrances2_pair = region2_hashmap.find(game_value("entrances"));
            auto* nodes1_pair = region1_hashmap.find(game_value("nodes"));
            auto* nodes2_pair = region2_hashmap.find(game_value("nodes"));
            if (!entrances1_pair || !entrances2_pair || !nodes1_pair || !nodes2_pair) return {0, 0, 0};

            auto& entrances1 = entrances1_pair->value.get_as<game_data_hashmap>().getRef()->data;
            auto& entrances2 = entrances2_pair->value.get_as<game_data_hashmap>().getRef()->data;
            auto& nodes1_arr = nodes1_pair->value.get_as<game_data_array>().getRef()->data;
            auto& nodes2_arr = nodes2_pair->value.get_as<game_data_array>().getRef()->data;

            float grid_step = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_gridStep"));
            float max_dist = grid_step * 2.0f;

            // Build spatial grid for border2
            auto spatial_grid = buildSpatialGrid(border2, max_dist);

            static const int cell_offsets[9][2] = {
                {-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,0}, {0,1}, {1,-1}, {1,0}, {1,1}
            };

            // Build query batch (аналог _query и _queryData)
            auto_array<game_value> query_batch;
            std::vector<ConnectionCandidate> query_data;
            int distance_checks = 0;

            for (const auto& node1 : border1) {
                int grid_x = static_cast<int>(std::floor(node1.position[0] / max_dist));
                int grid_y = static_cast<int>(std::floor(node1.position[1] / max_dist));

                for (int c = 0; c < 9; ++c) {
                    std::string check_key = std::to_string(grid_x + cell_offsets[c][0]) + "," + 
                                           std::to_string(grid_y + cell_offsets[c][1]);
                    
                    auto it = spatial_grid.find(check_key);
                    if (it == spatial_grid.end()) continue;

                    for (const auto& node2_pair : it->second) {
                        ++distance_checks;
                        float dist = rv_navigation::distance3d(node1.position, node2_pair.second);

                        if (dist <= max_dist) {
                            query_batch.push_back(game_value(std::vector<game_value>{
                                game_value(vector3{node1.position[0], node1.position[1], node1.position[2] + 0.4f}),
                                game_value(vector3{node2_pair.second[0], node2_pair.second[1], node2_pair.second[2] + 0.4f}),
                                game_value(object()),
                                game_value(object()),
                                game_value(true),
                                game_value(1),
                                game_value("VIEW"),
                                game_value("GEOM")
                            }));
                            query_data.push_back({node1.index, node2_pair.first, dist});
                        }
                    }
                }
            }

            if (query_batch.empty()) {
                return {0, 0, distance_checks};
            }

            // Execute batch raycast: lineIntersectsSurfaces [_query]
            game_value wrapped_queries = game_value(std::vector<game_value>{game_value(query_batch)});
            auto result_gv = intercept::client::host::functions.invoke_raw_unary(
                __sqf::unary__lineintersectssurfaces__array__ret__array,
                wrapped_queries
            );

            // Process results in single pass (аналог forEach _r)
            int connections_made = 0;
            if (!result_gv.is_nil() && result_gv.size() > 0) {
                auto& results_arr = result_gv.get_as<game_data_array>().getRef()->data;

                for (size_t i = 0; i < results_arr.size() && i < query_data.size(); ++i) {
                    auto& result_item = results_arr[i];
                    
                    // If no intersection (count _x == 0)
                    if (result_item.is_nil() || result_item.size() == 0) {
                        auto& candidate = query_data[i];
                        
                        int node_id1 = static_cast<int>(nodes1_arr[candidate.node_id1]);
                        int node_id2 = static_cast<int>(nodes2_arr[candidate.node_id2]);

                        // Create entrances
                        auto* ent1_to_2 = entrances1.find(game_value(region_key2));
                        if (!ent1_to_2) {
                            entrances1[game_value(region_key2)] = game_value(auto_array<game_value>{});
                            ent1_to_2 = entrances1.find(game_value(region_key2));
                        }
                        auto& ent1_arr = ent1_to_2->value.get_as<game_data_array>().getRef()->data;
                        
                        // pushBackUnique
                        bool found = false;
                        for (auto& gv : ent1_arr) {
                            if (static_cast<int>(gv) == node_id1) { found = true; break; }
                        }
                        if (!found) ent1_arr.push_back(game_value(node_id1));

                        auto* ent2_to_1 = entrances2.find(game_value(region_key1));
                        if (!ent2_to_1) {
                            entrances2[game_value(region_key1)] = game_value(auto_array<game_value>{});
                            ent2_to_1 = entrances2.find(game_value(region_key1));
                        }
                        auto& ent2_arr = ent2_to_1->value.get_as<game_data_array>().getRef()->data;
                        
                        found = false;
                        for (auto& gv : ent2_arr) {
                            if (static_cast<int>(gv) == node_id2) { found = true; break; }
                        }
                        if (!found) ent2_arr.push_back(game_value(node_id2));

                        // Update adjacency
                        auto* adj1 = adjacency_data.find(game_value(node_id1));
                        if (!adj1) {
                            adjacency_data[game_value(node_id1)] = game_value(auto_array<game_value>{});
                            adj1 = adjacency_data.find(game_value(node_id1));
                        }
                        auto& adj1_arr = adj1->value.get_as<game_data_array>().getRef()->data;
                        
                        found = false;
                        for (auto& conn : adj1_arr) {
                            if (static_cast<int>(conn.get_as<game_data_array>().getRef()->data[0]) == node_id2) {
                                found = true; break;
                            }
                        }
                        if (!found) {
                            adj1_arr.push_back(game_value(std::vector<game_value>{
                                game_value(node_id2), game_value(candidate.distance)
                            }));
                        }

                        auto* adj2 = adjacency_data.find(game_value(node_id2));
                        if (!adj2) {
                            adjacency_data[game_value(node_id2)] = game_value(auto_array<game_value>{});
                            adj2 = adjacency_data.find(game_value(node_id2));
                        }
                        auto& adj2_arr = adj2->value.get_as<game_data_array>().getRef()->data;
                        
                        found = false;
                        for (auto& conn : adj2_arr) {
                            if (static_cast<int>(conn.get_as<game_data_array>().getRef()->data[0]) == node_id1) {
                                found = true; break;
                            }
                        }
                        if (!found) {
                            adj2_arr.push_back(game_value(std::vector<game_value>{
                                game_value(node_id1), game_value(candidate.distance)
                            }));
                        }

                        ++connections_made;
                    }
                }
            }

            return {connections_made, static_cast<int>(query_batch.size()), distance_checks};
        }
        catch (const std::exception& e) {
            std::cerr << "buildEntrancesBetween error: " << e.what() << std::endl;
            return {0, 0, 0};
        }
    }

    int updateRegionEntrancesFast(const std::string& region_key) {
        try {
            auto ns = intercept::sqf::mission_namespace();
            auto regions = intercept::sqf::get_variable(ns, "ai_nav_regions");

            if (regions.is_nil()) return 0;

            auto& regions_data = regions.get_as<game_data_hashmap>().getRef()->data;
            
            if (!regions_data.find(game_value(region_key))) {
                return 0;
            }

            auto neighbor_keys = getNeighborRegionKeys(region_key);
            int updated_count = 0;

            for (const auto& neighbor_key : neighbor_keys) {
                if (regions_data.find(game_value(neighbor_key))) {
                    buildEntrancesBetween(region_key, neighbor_key);
                    ++updated_count;
                }
            }

            return updated_count;
        }
        catch (const std::exception& e) {
            std::cerr << "updateRegionEntrancesFast error: " << e.what() << std::endl;
            return 0;
        }
    }

    std::string generateRegionNodes(const std::vector<float>& pos, bool auto_save) {
        try {
            auto ns = intercept::sqf::mission_namespace();
            auto regions = intercept::sqf::get_variable(ns, "ai_nav_regions");
            auto nodes_global = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto adjacency = intercept::sqf::get_variable(ns, "ai_nav_adjacency");
            float region_size = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_regionSize"));
            float grid_step = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_gridStep"));
            float raycast_height = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_raycastHeight"));
            float max_slope = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_maxSlope"));
            float min_dist_z = static_cast<float>(intercept::sqf::get_variable(ns, "ai_nav_minDistZ"));

            // Get region key
            std::string region_key = rv_navigation::calculate_region_key_string(pos[0], pos[1], region_size);

            // Check if region already exists
            auto& regions_data = regions.get_as<game_data_hashmap>().getRef()->data;
            if (regions_data.find(game_value(region_key))) {
                return region_key; // Already exists
            }

            // Calculate region bounds
            float region_start_x = std::floor(pos[0] / region_size) * region_size;
            float region_start_y = std::floor(pos[1] / region_size) * region_size;
            float region_end_x = region_start_x + region_size - grid_step;
            float region_end_y = region_start_y + region_size - grid_step;

            // Build raycast queries for finding surfaces
            auto_array<game_value> query_pos;
            int grid_points = static_cast<int>((region_size / grid_step) * (region_size / grid_step));
            query_pos.reserve(grid_points);

            for (float xp = region_start_x; xp <= region_end_x + 0.01f; xp += grid_step) {
                for (float yp = region_start_y; yp <= region_end_y + 0.01f; yp += grid_step) {
                    query_pos.push_back(game_value(std::vector<game_value>{
                        game_value(vector3{xp, yp, raycast_height}),
                        game_value(vector3{xp, yp, 0}),
                        game_value(object()),
                        game_value(object()),
                        game_value(true),
                        game_value(-1),
                        game_value("ROADWAY"),
                        game_value("ROADWAY"),
                        game_value(false)
                    }));
                }
            }
            // Execute first batch raycast: lineIntersectsSurfaces [_queryPos]
            game_value wrapped_query_pos = game_value(std::vector<game_value>{game_value(query_pos)});
            auto hits_gv = intercept::client::host::functions.invoke_raw_unary(
                __sqf::unary__lineintersectssurfaces__array__ret__array,
                wrapped_query_pos
            );

            if (hits_gv.is_nil() || hits_gv.size() == 0) {
                return region_key; // No surfaces found
            }

            auto& hits_arr = hits_gv.get_as<game_data_array>().getRef()->data;

            // Build nodes and spatial grid
            std::vector<std::vector<float>> nodes;
            std::unordered_map<std::string, std::vector<std::pair<int, std::vector<float>>>> spatial_grid;
            float max_connection_dist = grid_step * 2.0f;

            static const int cell_offsets[9][2] = {
                {-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,0}, {0,1}, {1,-1}, {1,0}, {1,1}
            };

            auto_array<game_value> connection_query;
            std::vector<std::tuple<int, int, float>> connection_data; // [idx1, idx2, dist]

            // Process hits and build nodes
            for (const auto& hit_set_gv : hits_arr) {
                if (hit_set_gv.is_nil() || hit_set_gv.size() == 0) continue;

                auto& hit_set = hit_set_gv.get_as<game_data_array>().getRef()->data;
                
                // Reset prev_pos for each hit set (like SQF version)
                std::vector<float> prev_pos = {0, 0, 99999};

                for (size_t hit_idx = 0; hit_idx < hit_set.size(); ++hit_idx) {
                    auto& hit = hit_set[hit_idx].get_as<game_data_array>().getRef()->data;
                    
                    // hit = [pos, normal, obj, parentObj, ...]
                    auto& pos_arr = hit[0].get_as<game_data_array>().getRef()->data;
                    std::vector<float> hit_pos = {
                        static_cast<float>(pos_arr[0]),
                        static_cast<float>(pos_arr[1]),
                        static_cast<float>(pos_arr[2])
                    };

                    object hit_obj(hit[2]);

                    // Skip first hit (roof check) - simplified version
                    if (hit_idx == 0) {
                        // TODO: check ceiling - for now skip first hit
                        continue;
                    }

                    // Skip null reference (map surface)
                    if (hit_obj.is_null()) continue;

                    // Skip if too close to previous node in Z
                    if ((prev_pos[2] - hit_pos[2]) < min_dist_z) continue;

                    // Build connections with already added nodes
                    int current_idx = static_cast<int>(nodes.size());
                    int grid_x = static_cast<int>(std::floor(hit_pos[0] / max_connection_dist));
                    int grid_y = static_cast<int>(std::floor(hit_pos[1] / max_connection_dist));

                    // Check connections with nearby nodes
                    for (int c = 0; c < 9; ++c) {
                        std::string check_key = std::to_string(grid_x + cell_offsets[c][0]) + "," +
                                               std::to_string(grid_y + cell_offsets[c][1]);

                        auto it = spatial_grid.find(check_key);
                        if (it == spatial_grid.end()) continue;

                        for (const auto& neighbor_pair : it->second) {
                            int neighbor_idx = neighbor_pair.first;
                            const auto& neighbor_pos = neighbor_pair.second;

                            float dist = rv_navigation::distance3d(hit_pos, neighbor_pos);

                            if (dist <= max_connection_dist) {
                                float delta_z = std::abs(hit_pos[2] - neighbor_pos[2]);
                                if (delta_z > 1.0f) continue;

                                // Check slope (fast version)
                                float slope_tan = std::tan(max_slope * 3.14159265f / 180.0f);
                                if (delta_z / dist > slope_tan) continue;

                                // Add to connection query
                                connection_query.push_back(game_value(std::vector<game_value>{
                                    game_value(vector3{hit_pos[0], hit_pos[1], hit_pos[2] + 0.4f}),
                                    game_value(vector3{neighbor_pos[0], neighbor_pos[1], neighbor_pos[2] + 0.4f}),
                                    game_value(object()),
                                    game_value(object()),
                                    game_value(true),
                                    game_value(1),
                                    game_value("VIEW"),
                                    game_value("GEOM")
                                }));

                                connection_data.push_back({current_idx, neighbor_idx, dist});
                            }
                        }
                    }

                    // Add node to list
                    nodes.push_back(hit_pos);

                    // Add to spatial grid
                    std::string grid_key = std::to_string(grid_x) + "," + std::to_string(grid_y);
                    spatial_grid[grid_key].push_back({current_idx, hit_pos});

                    prev_pos = hit_pos;
                }
            }
            
            // Build edges list
            std::vector<std::tuple<std::vector<float>, std::vector<float>, float>> edges_list;

            if (!connection_query.empty()) {
                // Execute second batch raycast for connections
                game_value wrapped_conn_query = game_value(std::vector<game_value>{game_value(connection_query)});
                auto conn_hits_gv = intercept::client::host::functions.invoke_raw_unary(
                    __sqf::unary__lineintersectssurfaces__array__ret__array,
                    wrapped_conn_query
                );

                if (!conn_hits_gv.is_nil() && conn_hits_gv.size() > 0) {
                    auto& conn_results = conn_hits_gv.get_as<game_data_array>().getRef()->data;

                    for (size_t i = 0; i < conn_results.size() && i < connection_data.size(); ++i) {
                        auto& result = conn_results[i];
                        
                        // If no intersection (clear line of sight)
                        if (result.is_nil() || result.size() == 0) {
                            auto& conn = connection_data[i];
                            edges_list.push_back({
                                nodes[std::get<0>(conn)],
                                nodes[std::get<1>(conn)],
                                std::get<2>(conn)
                            });
                        }
                    }
                }
            }
            
            // Save region (if auto_save)
            if (auto_save) {
                saveRegion(region_key, nodes, edges_list);
            }

            return region_key;
        }
        catch (const std::exception& e) {
            std::cerr << "generateRegionNodes error: " << e.what() << std::endl;
            return "";
        }
    }

    void saveRegion(
        const std::string& region_key,
        const std::vector<std::vector<float>>& nodes,
        const std::vector<std::tuple<std::vector<float>, std::vector<float>, float>>& edges
    ) {
        try {
            auto ns = intercept::sqf::mission_namespace();
            auto regions = intercept::sqf::get_variable(ns, "ai_nav_regions");
            auto nodes_global = intercept::sqf::get_variable(ns, "ai_nav_nodes");
            auto adjacency = intercept::sqf::get_variable(ns, "ai_nav_adjacency");

            auto& regions_data = regions.get_as<game_data_hashmap>().getRef()->data;
            auto& nodes_data = nodes_global.get_as<game_data_hashmap>().getRef()->data;
            auto& adjacency_data = adjacency.get_as<game_data_hashmap>().getRef()->data;

            // Create region hashmap through SQF (uses proper allocator)
            game_value region_data = intercept::client::host::functions.invoke_raw_nular(
                __sqf::nular__createhashmap__ret__hashmap
            );
            
            // Get reference to hashmap data for filling
            auto region_hashmap = region_data.get_as<game_data_hashmap>();
            
            // Fill region hashmap
            game_value empty_entrances = intercept::client::host::functions.invoke_raw_nular(
                __sqf::nular__createhashmap__ret__hashmap
            );
            
            region_hashmap->data[game_value("lastUpdate")] = intercept::sqf::diag_ticktime();
            region_hashmap->data[game_value("nodes")] = game_value(auto_array<game_value>{}); // Will be filled
            region_hashmap->data[game_value("edges")] = game_value(auto_array<game_value>{}); // Not used in C++ version
            region_hashmap->data[game_value("entrances")] = empty_entrances; // Empty hashmap
            region_hashmap->data[game_value("mobs")] = game_value(auto_array<game_value>{});
            
            
            // Generate node IDs and save nodes
            auto_array<game_value> node_ids;
            node_ids.reserve(nodes.size());
            std::unordered_map<std::string, int> pos_to_id_map;

            // Get current node counter
            int node_counter = static_cast<int>(intercept::sqf::get_variable(ns, "ai_nav_nodeIdCounter"));
            for (const auto& node_pos : nodes) {
                int node_id = ++node_counter;
                
                // Create node hashmap through SQF (uses proper allocator)
                game_value node_data = intercept::client::host::functions.invoke_raw_nular(
                    __sqf::nular__createhashmap__ret__hashmap
                );
                
                // Fill node hashmap
                auto& node_hashmap = node_data.to_hashmap();
                node_hashmap[game_value("pos")] = game_value(vector3{node_pos[0], node_pos[1], node_pos[2]});
                node_hashmap[game_value("region")] = game_value(region_key);
                node_hashmap[game_value("neighbors")] = game_value(auto_array<game_value>{});
                
                // Save to global nodes
                nodes_data[game_value(node_id)] = node_data;
                node_ids.push_back(game_value(node_id));

                // Save position to ID mapping
                std::ostringstream pos_str;
                pos_str << node_pos[0] << "," << node_pos[1] << "," << node_pos[2];
                pos_to_id_map[pos_str.str()] = node_id;
            }

            // Update node counter
            intercept::sqf::set_variable(ns, "ai_nav_nodeIdCounter", game_value(node_counter));

            // Update region nodes list
            region_hashmap->data[game_value("nodes")] = game_value(node_ids);

            // Process edges and update adjacency
            for (const auto& edge : edges) {
                const auto& pos1 = std::get<0>(edge);
                const auto& pos2 = std::get<1>(edge);
                float cost = std::get<2>(edge);

                std::ostringstream pos1_str, pos2_str;
                pos1_str << pos1[0] << "," << pos1[1] << "," << pos1[2];
                pos2_str << pos2[0] << "," << pos2[1] << "," << pos2[2];

                auto it1 = pos_to_id_map.find(pos1_str.str());
                auto it2 = pos_to_id_map.find(pos2_str.str());

                if (it1 != pos_to_id_map.end() && it2 != pos_to_id_map.end()) {
                    int node_id1 = it1->second;
                    int node_id2 = it2->second;

                    // Create or get adjacency list for node1
                    auto* adj1 = adjacency_data.find(game_value(node_id1));
                    if (!adj1) {
                        adjacency_data[game_value(node_id1)] = game_value(auto_array<game_value>{});
                        adj1 = adjacency_data.find(game_value(node_id1));
                    }
                    auto& adj1_arr = adj1->value.get_as<game_data_array>().getRef()->data;

                    // pushBackUnique [node_id2, cost]
                    bool found = false;
                    for (auto& conn : adj1_arr) {
                        if (static_cast<int>(conn.get_as<game_data_array>().getRef()->data[0]) == node_id2) {
                            found = true; break;
                        }
                    }
                    if (!found) {
                        adj1_arr.push_back(game_value(std::vector<game_value>{
                            game_value(node_id2), game_value(cost)
                        }));
                    }

                    // Create or get adjacency list for node2
                    auto* adj2 = adjacency_data.find(game_value(node_id2));
                    if (!adj2) {
                        adjacency_data[game_value(node_id2)] = game_value(auto_array<game_value>{});
                        adj2 = adjacency_data.find(game_value(node_id2));
                    }
                    auto& adj2_arr = adj2->value.get_as<game_data_array>().getRef()->data;

                    // pushBackUnique [node_id1, cost]
                    found = false;
                    for (auto& conn : adj2_arr) {
                        if (static_cast<int>(conn.get_as<game_data_array>().getRef()->data[0]) == node_id1) {
                            found = true; break;
                        }
                    }
                    if (!found) {
                        adj2_arr.push_back(game_value(std::vector<game_value>{
                            game_value(node_id1), game_value(cost)
                        }));
                    }
                }
            }

            // Save region
            regions_data[game_value(region_key)] = region_data;
        }
        catch (const std::exception& e) {
            std::cerr << "saveRegion error: " << e.what() << std::endl;
        }
    }

    std::vector<int> invalidateRegion(const std::string& region_key) {
        try {
            // For now, call SQF function directly as C++ hashmap doesn't have deleteAt method
            // We'll just return empty array and let SQF handle the deletion
            // This is a placeholder - full implementation would require SQF command execution
            
            auto ns = intercept::sqf::mission_namespace();
            
            // Store region key in temp variable
            intercept::sqf::set_variable(ns, "rve_temp_region_key", game_value(region_key));
            
            // Call SQF invalidation via code
            auto result = intercept::sqf::call(intercept::sqf::compile(
                "[missionNamespace getVariable 'rve_temp_region_key'] call ai_nav_invalidateRegion"
            ));
            
            // Extract mobs from result
            std::vector<int> old_mobs;
            if (!result.is_nil()) {
                auto& mobs_arr = result.get_as<game_data_array>().getRef()->data;
                for (const auto& mob_gv : mobs_arr) {
                    old_mobs.push_back(static_cast<int>(mob_gv));
                }
            }

            return old_mobs;
        }
        catch (const std::exception& e) {
            std::cerr << "invalidateRegion error: " << e.what() << std::endl;
            return {};
        }
    }

} // namespace rv_navigation_region

