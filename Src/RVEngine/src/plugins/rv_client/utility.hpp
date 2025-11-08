#pragma once

#include "intercept.hpp"

using namespace intercept;

namespace rv_utility {

    // ============================================================================
    // SIGNAL RETURN VALUE UTILITY
    // ============================================================================

    // Set return value for signal/native function call
    // This stores the value in mission namespace under "rve_sigret" variable
    template<typename T>
    inline void setSignalReturn(const T& value) {
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", value);
    }

    // Overload for int
    inline void setSignalReturn(int value) {
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(value));
    }

    // Overload for float
    inline void setSignalReturn(float value) {
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(value));
    }

    // Overload for bool
    inline void setSignalReturn(bool value) {
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(value));
    }

    // Overload for string
    inline void setSignalReturn(const std::string& value) {
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(value));
    }

    // Overload for game_value
    inline void setSignalReturn(const game_value& value) {
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", value);
    }

    // Overload for vector<game_value> (array)
    inline void setSignalReturn(const std::vector<game_value>& value) {
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(value));
    }

    // Overload for vector<int>
    inline void setSignalReturn(const std::vector<int>& value) {
        std::vector<game_value> gv_array;
        gv_array.reserve(value.size());
        for (int v : value) {
            gv_array.push_back(game_value(v));
        }
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(gv_array));
    }

    // Overload for vector<float>
    inline void setSignalReturn(const std::vector<float>& value) {
        std::vector<game_value> gv_array;
        gv_array.reserve(value.size());
        for (float v : value) {
            gv_array.push_back(game_value(v));
        }
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(gv_array));
    }

    // Overload for vector<vector<float>> (array of positions)
    inline void setSignalReturn(const std::vector<std::vector<float>>& value) {
        std::vector<game_value> gv_array;
        gv_array.reserve(value.size());
        for (const auto& vec : value) {
            std::vector<game_value> gv_vec;
            gv_vec.reserve(vec.size());
            for (float v : vec) {
                gv_vec.push_back(game_value(v));
            }
            gv_array.push_back(game_value(gv_vec));
        }
        sqf::set_variable(intercept::sqf::mission_namespace(), "rve_sigret", game_value(gv_array));
    }

} // namespace rv_utility

