# A really bad laptop charger: Playdate component
This is the playdate component for Mine and @headblockhead's Scrapyard London submission.
It's written in lua on my NixOS laptop.

## How does this work?
- Spin the crank
- Every 10 cranks, it sends "Cranked" over serial
- This is then detected by a bash script


## Building
> ![INFO]
> You need the Playdate SDK correctly installed
1. Run either the build_and_run.sh (On linux) or the ps1 alternative
2. Build
3. Flash to your playdate via USB/The Simulator

Done!
