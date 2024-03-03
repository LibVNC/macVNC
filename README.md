[![CI](https://github.com/LibVNC/macVNC/actions/workflows/ci.yml/badge.svg)](https://github.com/LibVNC/macVNC/actions/workflows/ci.yml)

# About

macVNC is a simple command-line VNC server for macOS.

It is [based on the macOS server example from LibVNCServer](https://github.com/LibVNC/libvncserver/commits/6e5f96e3ea53bf85cec7d985b120daf1c91ce0d9/examples/mac.c?browsing_rename_history=true&new_path=examples/server/mac.c&original_branch=master)
which in turn is based on OSXvnc by Dan McGuirk which again is based on the original VNC
GPL dump by AT&T Cambridge.

## Features

* Fully multi-threaded.
* Double-buffering for framebuffer updates.
* Mouse and keyboard input.
* Multi-monitor support.

# Building

macVNC uses CMake, thus it's:

    mkdir build
    cd build
    cmake ..
    cmake --build .

# License

As its predecessors, macVNC is licensed under the GPL version 2. See [COPYING](COPYING) for more information.




