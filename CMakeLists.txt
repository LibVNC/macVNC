cmake_minimum_required(VERSION 3.18)
project(macVNC VERSION 0.1.0 LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
if(CMAKE_GENERATOR MATCHES "Unix Makefiles|Ninja")
# some LSP servers expect compile_commands.json in the project root
add_custom_target(
    macvnc-copy-compile-commands ALL
    ${CMAKE_COMMAND} -E copy_if_different
        ${CMAKE_BINARY_DIR}/compile_commands.json
        ${CMAKE_CURRENT_SOURCE_DIR}
    )
endif(CMAKE_GENERATOR MATCHES "Unix Makefiles|Ninja")

#
# Dependencies
#
find_package(LibVNCServer REQUIRED)
find_package(Threads REQUIRED)
find_library(CARBON_LIBRARY Carbon REQUIRED)
find_library(IOKIT_LIBRARY IOKit REQUIRED)
find_library(IOSURFACE_LIBRARY IOSurface REQUIRED)

#
# Sources
#
set(SOURCE_FILES
    src/mac.c
)

add_executable(macvnc src/mac.c)
target_link_libraries(macvnc LibVNCServer::vncserver ${CMAKE_THREAD_LIBS_INIT} ${CARBON_LIBRARY} ${IOKIT_LIBRARY} ${IOSURFACE_LIBRARY})

