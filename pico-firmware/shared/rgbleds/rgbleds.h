#pragma once

#include "hardware/pio.h"
#include "ws2812.pio.h"

void rgbleds_update(uint8_t *leds, uint pixel_count, uint amount);
void rgbleds_init(uint gpio);
