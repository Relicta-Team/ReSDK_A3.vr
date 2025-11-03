#include "intercept.hpp"
#include <Windows.h>
#include <string>

using namespace intercept;

// Required exported function to return API version
extern "C" {
    DLLEXPORT int CDECL api_version() {
        return INTERCEPT_SDK_API_VERSION;
    }

    // Optional lifecycle hooks
    DLLEXPORT void CDECL pre_start() {
        // Called before initFunctions
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

    DLLEXPORT void CDECL register_interfaces() {
        
    }

    DLLEXPORT void CDECL handle_unload() {
        // Cleanup before unload
    }

    DLLEXPORT bool CDECL is_signed() {
        return false; // Set to true if your plugin is signed
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
