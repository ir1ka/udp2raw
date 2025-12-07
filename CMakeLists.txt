#note: experimental
#      currently only used for generating `compile_commands.json` for clangd.
#      to build this project, it's suggested to use `makefile` instead

cmake_minimum_required(VERSION 3.7)
project(udp2raw)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 11)

execute_process(
    COMMAND make git_version -C ${CMAKE_SOURCE_DIR}
)

enable_language(ASM)

set(SOURCE_FILES
        main.cpp
        lib/md5.cpp
        lib/pbkdf2-sha1.cpp
        lib/pbkdf2-sha256.cpp
        encrypt.cpp
        log.cpp
        network.cpp
        common.cpp
        connection.cpp
        misc.cpp
        fd_manager.cpp
        client.cpp
        server.cpp
        lib/aes_acc/aesacc.c
        lib/aes_acc/aesarm.c
        lib/aes_acc/aesni.c
        my_ev.cpp
        lib/aes_acc/asm/x64.S
)

add_executable(udp2raw ${SOURCE_FILES})
target_compile_options(udp2raw PRIVATE
    -Wall
    -Wextra
    -Wno-unused-variable
    -Wno-unused-parameter
    -Wno-missing-field-initializers
)
target_link_options(udp2raw PRIVATE
    -static
)
target_link_libraries(udp2raw rt)
target_link_libraries(udp2raw pthread)
target_link_libraries(udp2raw gcc_eh)
include_directories(SYSTEM "libev")
include_directories(".")
