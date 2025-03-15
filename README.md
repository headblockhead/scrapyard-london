# CrankCharge - a Garbage™ laptop charger

Have you ever really needed to charge your laptop, but also want to get unreasonable amounts of arm exercise, but just so happen to really hate normal chargers, and going to the gym?

Now you can!

## Huh?

CrankCharge mesaures a [PlayDate](https://play.date)'s crank, and only charges the laptop if you spin the crank fast enough. Helpful RGB LEDs are provided to provide you with rainbow-coloured motivation, and a mild case of eye pain. Finally, Home Assistant controls a smartplug to enforce the charging rules, so you MUST spin the crank to charge your laptop.

## How?

The RGB LEDs are controlled by a raspberry pi pico running custom firmware that reads data from USB serial. The PlayDate outputs the amount of cranks performed over USB serial too. A bash script interprets the crank amount and outputs it to the RPI Pico, and sends HTTP requests to Home Assistant's REST API to toggle the wifi switch on and off.
