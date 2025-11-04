#pragma once

#include "ai.hpp"
#include "actions.hpp"
#include "chat.hpp"
#include "core.hpp"
#include "position.hpp"
#include "misc.hpp"
#include "intersects.hpp"
#include "world.hpp"
#include "ctrl.hpp"
#include "marker.hpp"
#include "curator.hpp"
#include "eden.hpp"
#include "group.hpp"
#include "multiplayer.hpp"
#include "config.hpp"
#include "camera.hpp"
#include "inventory.hpp"
#include "hc.hpp"
#include "sound.hpp"
#include "cargo.hpp"
#include "tasks.hpp"
#include "debug.hpp"
#include "rotorlib.hpp"
#include "units.hpp"
#include "vehicles.hpp"
#include "waypoint.hpp"

#include "uncategorized.hpp"
#include <regex>

#define __XXXSQF_QUOTE(...) #__VA_ARGS__
#define __XXXSQF_EXPAND_AND_QUOTE(str) __XXXSQF_QUOTE(str)
#define __XXXSQF_L1(...) __SQF(##__VA_ARGS__##)__SQF
#define __XXXSQF_L2(...) __XXXSQF_EXPAND_AND_QUOTE(__XXXSQF_L1(__VA_ARGS__))

#define __XXXSQF_CAT(a,b) a##b
#define __XXXSQF_EXPAND_AND_CAT(a,b) __XXXSQF_CAT(a,b)

#define __XXXSQF_ARG(...) __XXXSQF_EXPAND_AND_CAT(R,__XXXSQF_L2(__VA_ARGS__))

#define __SQF(...) __inline_sqf_helper_launcher::generate(__XXXSQF_ARG(__VA_ARGS__))

class __inline_sqf_helper_launcher {
protected:
    class __inline_sqf_helper {
    public:
        /**
         * @brief Creates a helper that holds SQF code for deferred compilation and execution on destruction.
         *
         * @param sqf_ SQF code string to store; the stored code will be sanitized, compiled, and invoked when the helper is destroyed.
         */
        __inline_sqf_helper(std::string&& sqf_) : _sqf(std::move(sqf_)), _do_return(false), _capture_return(nullptr) {
            _capture_args = game_value();
        }

        /**
         * @brief Executes the stored SQF code with captured arguments and optionally stores its return value.
         *
         * On destruction, the helper prepares the stored SQF text, compiles it, and invokes the compiled SQF
         * function with the previously captured arguments. If a capture return reference was provided,
         * the invocation result is stored into that reference; otherwise the result is discarded.
         */
        ~__inline_sqf_helper() {
            const std::regex escape("\\\\(.)");
            _sqf = std::regex_replace(_sqf, escape, "$1");
            const auto sqf_fnc = intercept::sqf::compile(_sqf);
            if (_capture_return) {
                *_capture_return = intercept::sqf::call(sqf_fnc, _capture_args);
            } else {
                intercept::sqf::call(sqf_fnc, _capture_args);
            }
        }

        /**
         * @brief Store the arguments that will be passed to the compiled SQF when the helper executes.
         *
         * The provided `capture_args_` is moved into the helper and used as the invocation arguments for
         * the compiled SQF function performed in the helper's destructor.
         *
         * @param capture_args_ Arguments to pass to the compiled SQF function; ownership is moved into the helper.
         */
        void capture(game_value capture_args_) {
            _capture_args = std::move(capture_args_);
        }

        /**
         * @brief Register arguments and a destination for the SQF call's return value.
         *
         * Stores the provided arguments (by move) and records the address of `capture_return_`
         * so the helper will write the SQF call's result into it when the helper executes.
         *
         * @param capture_args_ Arguments to pass to the compiled SQF code; ownership is taken.
         * @param capture_return_ Reference to a `game_value` that will be assigned the call result.
         *
         * @note The caller must ensure `capture_return_` remains valid for the lifetime of the helper.
         */
        void capture(game_value capture_args_, game_value &capture_return_) {
            _capture_args = std::move(capture_args_);
            _capture_return = &capture_return_;
            _do_return = true;
        }

    protected:
        std::string _sqf;
        bool _do_return;
        game_value _capture_args;
        game_value *_capture_return;
    };

public:
    /**
     * @brief Creates a helper that will compile and execute the given SQF code when it goes out of scope.
     *
     * @param sqf_ SQF source code to compile and execute.
     * @return __inline_sqf_helper Helper configured to compile and invoke the provided SQF; on destruction it will call the compiled code with any captured arguments and optionally store a return value.
     */
    static __inline_sqf_helper generate(std::string sqf_) {
        return __inline_sqf_helper(std::move(sqf_));
    }
};