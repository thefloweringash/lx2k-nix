{ stdenv, lib, fetchgit, uboot, rcw, openssl,
  ddrSpeed ? 3200,
  serdes ? "8_5_2",
  bootMode ? "sd",
}:

assert lib.elem ddrSpeed [ 2400 2600 2900 3200 ];
assert lib.elem bootMode [ "sd" "spi" ];

let
  atfBoot = if bootMode == "sd" then "sd" else "flexspi_nor";

  speed = "2000_700_${toString ddrSpeed}";
in

stdenv.mkDerivation rec {
  pname = "atf";
  version = "LSDK-19.09";

  src = fetchgit {
    url = "https://source.codeaurora.org/external/qoriq/qoriq-components/atf";
    rev = "refs/tags/${version}";
    sha256 = "1jskw423il746pr1aaw4d2m2s0hg9f3fw4zir950alwvy1a4a8bd";
  };

  patches = [
    ../patches/atf/0001-plat-nxp-Add-lx2160acex7-module-support.patch
  ];

  buildInputs = [ openssl ];

  makeFlags = [
    "PLAT=lx2160acex7"
    "BL33=${uboot}/u-boot.bin"
    "RCW=${rcw}/lx2160acex7/XGGFF_PP_HHHH_RR_19_5_2/rcw_${speed}_${serdes}_${bootMode}.bin"
    "TRUSTED_BOARD_BOOT=0"
    "GENERATE_COT=0"
    "BOOT_MODE=${atfBoot}"
    "SECURE_BOOT=false"
    "all" "fip" "pbl"
  ];

  hardeningDisable = [ "all" ];

  installPhase = ''
    mkdir -p $out/lx2160acex7
    cp -v --target-directory $out/lx2160acex7 \
      build/lx2160acex7/release/*.bin \
      build/lx2160acex7/release/*.pbl

    mkdir -p $out/bin
    cp -v tools/fiptool/fiptool $out/bin
  '';

  passthru = {
    inherit atfBoot serdes;
  };
}
