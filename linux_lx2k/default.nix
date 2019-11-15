{ stdenv, runCommand, fetchgit, linuxManualConfig,
  features ? {}, kernelPatches ? [], randstructSeed ? null }:

# Additional features cannot be added to this kernel
assert features == {};

let
  passthru = { features = {}; };

  drv = linuxManualConfig ({
    inherit stdenv kernelPatches;

    src = fetchgit {
      url = "https://source.codeaurora.org/external/qoriq/qoriq-components/linux";
      rev = "33f2c86df727a5651c22329265704adfa3518549";
      sha256 = "1b2myggckk0l5r3nvjjc5z9n72ghnz245p1dl1mbjp04m9m9az1a";
    };

    version = "4.19.46";
    modDirVersion = "4.19.46";

    configfile = ./config;

    allowImportFromDerivation = true; # Let nix check the assertions about the config
  } // stdenv.lib.optionalAttrs (randstructSeed != null) { inherit randstructSeed; });

in

stdenv.lib.extendDerivation true passthru drv
