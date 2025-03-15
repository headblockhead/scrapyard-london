// pico SDK
#include <hardware/flash.h>
#include <hardware/pio.h>
#include <pico/flash.h>
#include <pico/multicore.h>
#include <pico/stdio.h>

// shared
#include <rgbleds.h>

// WS2812 LED strip data input
#define GPIO_WS2812 0

#define NUM_PIXELS 150 // 20 keys + 9 LEDs in a bar along the side.
// leds stores the R, G, and B values for each LED in the LED strip.
uint8_t leds[NUM_PIXELS * 3] = {0};

uint led_amount = 150;

// Core 1 deals with the LED strip and OLED display.
void core1_main(void) {
  while (true) {
    rgbleds_update(leds, NUM_PIXELS, led_amount); // Update the LED strip.
  }
}

// Core 0 deals with keyboard and USB HID.
void core0_main(void) {
  while (true) {
    scanf("%d", &led_amount);
  }
}

// The main function, runs initialization.
int main(void) {
  stdio_init_all();
  rgbleds_init(GPIO_WS2812);

  multicore_launch_core1(core1_main);
  core0_main();
}
