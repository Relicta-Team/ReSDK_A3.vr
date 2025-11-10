cmake_minimum_required (VERSION 3.8)
project(Intercept)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Add CMake modules path
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/CMakeModules")

# Include custom CMake functions
include(cxx_compiler_functions)

# Set C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Build options
option(DEVEL "DEVEL" ON)
option(USE_STATIC_LINKING "USE_STATIC_LINKING" ON)
option(USE_SYSTEM_SPDLOG "USE_SYSTEM_SPDLOG" OFF)
option(USE_64BIT_BUILD "USE_64BIT_BUILD" ON)
option(BUILD_PLUGINS "Build Intercept plugins" ON)

# Set output directories for all build artifacts
# All output will go to vcproj64/build/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build")

# Set per-configuration output directories
foreach(OUTPUTCONFIG ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER ${OUTPUTCONFIG} OUTPUTCONFIG_UPPER)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${OUTPUTCONFIG_UPPER} "${CMAKE_BINARY_DIR}/build/${OUTPUTCONFIG}")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${OUTPUTCONFIG_UPPER} "${CMAKE_BINARY_DIR}/build/${OUTPUTCONFIG}")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${OUTPUTCONFIG_UPPER} "${CMAKE_BINARY_DIR}/build/${OUTPUTCONFIG}")
endforeach()

# Set link type based on USE_STATIC_LINKING option
if(USE_STATIC_LINKING)
    set(INTERCEPT_LINK_TYPE "static")
else()
    set(INTERCEPT_LINK_TYPE "dynamic")
endif()

if (NOT CMAKE_BUILD_TYPE AND CMAKE_COMPILER_IS_GNUCXX)
    message(STATUS "No build type selected, default to Debug")
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# Add subdirectories
add_subdirectory(src/host)
add_subdirectory(src/client)

# Add plugins if option is enabled
if(BUILD_PLUGINS)
    add_subdirectory(src/plugins)
endif()

message("Build Type: ${CMAKE_BUILD_TYPE}")
message("Output Directory: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
message("Build Plugins: ${BUILD_PLUGINS}")

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    message("clang is unsupported for usage with Arma")
endif()