// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#pragma once

#include "intercept.hpp"
#include <string>
#include <vector>
#include <unordered_map>

using namespace intercept;

namespace rv_navigation {

    // ============================================================================
    // HELPER FUNCTIONS
    // ============================================================================

    // Calculate region key string from position
    std::string calculate_region_key_string(float x, float y, float region_size = 10.0f);

    // Calculate distance between two 3D points
    float distance3d(const std::vector<float>& p1, const std::vector<float>& p2);

    // Get position from node data (game_value)
    std::vector<float> get_node_position(const game_value& node_data);

    // ============================================================================
    // CORE NAVIGATION FUNCTIONS (return values)
    // ============================================================================

    // Find nearest navigation node to position
    // Returns: nodeId or -1 if not found
    int findNearestNode(
        const std::vector<float>& search_pos,
        float max_distance = 50.0f
    );

    // A* pathfinding to closest node near target position
    // Returns: vector of nodeIds (path)
    std::vector<int> findPathToClosestNode(
        int start_node_id,
        const std::vector<float>& target_pos,
        float early_exit_dist = 2.0f
    );

    // Main pathfinding function
    // Returns: vector of positions [x,y,z]
    std::vector<std::vector<float>> findPartialPath(
        const std::vector<float>& start_pos,
        const std::vector<float>& end_pos,
        bool optimize = true,
        std::vector<int>* out_path_nodes = nullptr
    );

    // ============================================================================
    // PATH SMOOTHING FUNCTIONS
    // ============================================================================

    // Simple path smoothing (removes points if direction doesn't change much)
    std::vector<std::vector<float>> smoothPathFast(
        const std::vector<std::vector<float>>& path
    );

    // Aggressive path smoothing (removes more points based on angle threshold)
    std::vector<std::vector<float>> smoothPathAggressive(
        const std::vector<std::vector<float>>& path,
        float angle_threshold_deg = 20.0f
    );

    // Line-of-sight based path smoothing
    std::vector<std::vector<float>> smoothPathLineOfSight(
        const std::vector<std::vector<float>>& path
    );

    // Check if there's line of sight between two positions
    bool hasLineOfSight(
        const std::vector<float>& pos1,
        const std::vector<float>& pos2
    );

} // namespace rv_navigation

