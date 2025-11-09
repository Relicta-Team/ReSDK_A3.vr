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

namespace rv_navigation_region {

    // ============================================================================
    // STRUCTURES
    // ============================================================================

    struct BorderNode {
        int node_id;
        int index;
        std::vector<float> position;
    };

    struct ConnectionCandidate {
        int node_id1;
        int node_id2;
        float distance;
    };

    // ============================================================================
    // HELPER FUNCTIONS
    // ============================================================================

    // Get border nodes for a region in specific direction
    std::vector<BorderNode> getBorderNodes(
        const std::string& region_key,
        int dx,
        int dy
    );

    // Build spatial grid for nodes
    std::unordered_map<std::string, std::vector<std::pair<int, std::vector<float>>>> buildSpatialGrid(
        const std::vector<BorderNode>& nodes,
        float grid_size
    );

    // ============================================================================
    // CORE REGION UPDATE FUNCTIONS
    // ============================================================================

    // Build entrance points between two regions
    // Returns: [connection_count, raycast_count, distance_checks]
    std::vector<int> buildEntrancesBetween(
        const std::string& region_key1,
        const std::string& region_key2
    );

    // Update entrances for a region (fast version)
    // Returns: number of neighbors updated
    int updateRegionEntrancesFast(
        const std::string& region_key
    );

    // Generate region nodes
    // Returns: region_key
    std::string generateRegionNodes(
        const std::vector<float>& pos,
        bool auto_save = true
    );

    // Save region data to global structures
    void saveRegion(
        const std::string& region_key,
        const std::vector<std::vector<float>>& nodes,
        const std::vector<std::tuple<std::vector<float>, std::vector<float>, float>>& edges
    );

    // Invalidate region (remove old data)
    // Returns: array of mob IDs that were in the region
    std::vector<int> invalidateRegion(
        const std::string& region_key
    );


    // ============================================================================
    // UTILITY FUNCTIONS
    // ============================================================================

    // Parse region key to coordinates
    void parseRegionKey(const std::string& region_key, int& rx, int& ry);

    // Get neighbor region keys (8 directions)
    std::vector<std::string> getNeighborRegionKeys(const std::string& region_key);

    // Get region bounds
    void getRegionBounds(
        const std::string& region_key,
        float& min_x, float& max_x,
        float& min_y, float& max_y
    );

} // namespace rv_navigation_region

