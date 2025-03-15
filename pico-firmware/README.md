# scrapyard garbage laptop charger
## Tasks

> [!IMPORTANT]
> You must be in the `nix develop` shell for these tasks to work!

### upload
Directory: ./build
Requires: build

Builds and uploads the firmware to the RP2040.

```bash
export PICO_DIR=`findmnt -S LABEL=RPI-RP2 -o TARGET -fn`
cp ./slab.uf2 $PICO_DIR
```

### upload-dbg
Directory: ./build
Requires: build-dbg

Builds and uploads debug firmware to the RP2040.

```bash
export PICO_DIR=`findmnt -S LABEL=RPI-RP2 -o TARGET -fn`
cp ./slab.uf2 $PICO_DIR
```

### build
Directory: ./build

```bash
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . -j $(nproc)
```

### build-dbg
Directory: ./build

Builds the keyboard firmware with development outputs.

```bash
cmake -DCMAKE_BUILD_TYPE=Debug .. 
cmake --build . -j $(nproc)
cp compile_commands.json ../ # Copies the autocomplete information for ccls.
```

### clean

Deletes the contents of the build directory.

```bash
rm -rf ./build
mkdir build
```

