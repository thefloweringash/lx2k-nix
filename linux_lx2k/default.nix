{ stdenv, lib, runCommand, fetchgit, linuxManualConfig,
  features ? {}, kernelPatches ? [], randstructSeed ? null }:

# Additional features cannot be added to this kernel
assert features == {};

let
  passthru = { features = {}; };

  drv = linuxManualConfig ({
    inherit stdenv kernelPatches;

    src = fetchgit {
      url = "https://source.codeaurora.org/external/qoriq/qoriq-components/linux";
      rev = "LSDK-19.09-V4.19";
      sha256 = "03ckcl8sfrmm0305j15i2bxyg4yhnwz5a8i5hcxb4l9gb0j1crv6";
    };

    version = "4.19.68";
    modDirVersion = "4.19.68";

    configfile = ./config;

    allowImportFromDerivation = true; # Let nix check the assertions about the config
  } // lib.optionalAttrs (randstructSeed != null) { inherit randstructSeed; }
    // lib.optionalAttrs (lib.versionAtLeast lib.version "21.05") { inherit lib; });

in

lib.extendDerivation true passthru drv
