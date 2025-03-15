cmake_minimum_required(VERSION 3.13)
set(PICO_BOARD pico_w)

# Find SDK using PICO_SDK_PATH
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

if(PICO_SDK_VERSION_STRING VERSION_LESS "1.3.0")
  message(
    FATAL_ERROR
      "Raspberry Pi Pico SDK version 1.3.0 (or later) required. Your version is ${PICO_SDK_VERSION_STRING}"
  )
endif()

project(slab C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
  add_compile_options(-Og)
else()
  add_compile_options(-Os)
endif()

# Initialize the SDK
pico_sdk_init()

add_subdirectory(${PROJECT_SOURCE_DIR}/shared/rgbleds rgbleds)

add_subdirectory(pico)
