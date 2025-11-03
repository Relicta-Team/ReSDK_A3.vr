# Plugins directory CMakeLists.txt
message(STATUS "Configuring Intercept plugins...")

# Add plugin subdirectories here
add_subdirectory(rv_client)

# To add more plugins, just add more lines:
# add_subdirectory(another_plugin)
# add_subdirectory(third_plugin)