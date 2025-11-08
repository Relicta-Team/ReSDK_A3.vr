cmake_minimum_required(VERSION 3.8)

# Plugin name
set(PLUGIN_NAME "rv_client")
set(PLUGIN_TARGET "${PLUGIN_NAME}_x64")

# Create shared library (DLL)
add_library(${PLUGIN_TARGET} SHARED)

# Set output name - will create rv_client_x64.dll
set_target_properties(${PLUGIN_TARGET} PROPERTIES
    OUTPUT_NAME "${PLUGIN_NAME}_x64"
    PREFIX ""
)

# Set property for CMakeInclude.txt
set_property(GLOBAL PROPERTY INTERCEPT_CLIENT_TARGET ${PLUGIN_TARGET})

# Include Intercept SDK
include(${CMAKE_SOURCE_DIR}/CMakeInclude.txt)

# Plugin sources
target_sources(${PLUGIN_TARGET} PRIVATE
    main.cpp
    navigation.cpp
    navigation.hpp
    navigation_region.cpp
    navigation_region.hpp
    utility.hpp
)

# Set output directory to build/plugins/
set_target_properties(${PLUGIN_TARGET} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build/plugins"
    RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/build/Debug/plugins"
    RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/build/Release/plugins"
    RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_BINARY_DIR}/build/MinSizeRel/plugins"
    RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_BINARY_DIR}/build/RelWithDebInfo/plugins"
)

# Set folder for IDE organization
set_target_properties(${PLUGIN_TARGET} PROPERTIES
    FOLDER "Plugins"
)

message(STATUS "Configuring plugin: ${PLUGIN_TARGET} -> ${PLUGIN_NAME}_x64.dll")
message(STATUS "Plugin output: ${CMAKE_BINARY_DIR}/build/[Config]/plugins/")