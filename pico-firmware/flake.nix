{
  description = "Pico firmware to display crank speed";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (final: prev: {
                picotool = prev.picotool.overrideAttrs
                  ({
                    version = "a672c2495a1a4cd5637d44a4842ef2274f1af492";
                    src = prev.fetchFromGitHub {
                      owner = "raspberrypi";
                      repo = "picotool";
                      rev = "a672c2495a1a4cd5637d44a4842ef2274f1af492";
                      fetchSubmodules = true;
                      hash = "sha256-xGFtKK8hEcP+qNGjRztBCrQfQelAWOI9jDyIqou6F0c=";
                    };
                  });
                pico-sdk = prev.pico-sdk.overrideAttrs
                  ({
                    version = "969f5895aa6790a9c1af8ed31ccd06cc81fe36cf";
                    src = prev.fetchFromGitHub {
                      owner = "raspberrypi";
                      repo = "pico-sdk";
                      rev = "969f5895aa6790a9c1af8ed31ccd06cc81fe36cf";
                      fetchSubmodules = true;
                      hash = "sha256-7WVWGUAGVuWrxvZ/oapufCZ87btRvgXSfTk9nYTAMb0=";
                    };
                  });
              })
            ];
          };
        in
        rec {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              xc
              cmake
              gcc-arm-embedded
              picotool
              python39
            ];
            env = {
              PICO_SDK_PATH = "${pkgs.pico-sdk}/lib/pico-sdk";
            };
          };
          packages.slab-firmware = pkgs.stdenv.mkDerivation {
            name = "slab-firmware";
            src = ./.;

            nativeBuildInputs = with pkgs; [
              cmake
              gcc-arm-embedded
              picotool
              python39
            ];
            cmakeFlags = [
              "-DCMAKE_C_COMPILER=${pkgs.gcc-arm-embedded}/bin/arm-none-eabi-gcc"
              "-DCMAKE_CXX_COMPILER=${pkgs.gcc-arm-embedded}/bin/arm-none-eabi-g++"
            ];
            env = {
              PICO_SDK_PATH = "${pkgs.pico-sdk}/lib/pico-sdk";
            };
            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp pico/{*.bin,*.elf,*.uf2,*.elf.map,*.dis} $out
              runHook postInstall
            '';
          };
          packages.default = packages.slab-firmware;
        }
      );
}
