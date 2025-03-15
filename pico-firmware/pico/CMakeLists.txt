add_executable(slab-pico ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_include_directories(slab-pico PRIVATE ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(slab-pico rgbleds pico_stdlib pico_multicore pico_flash)

pico_enable_stdio_uart(slab-pico 0)
pico_enable_stdio_usb(slab-pico 1)

pico_add_extra_outputs(slab-pico)
