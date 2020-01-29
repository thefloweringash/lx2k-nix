{ stdenv, lib, fetchgit, python3 }:

stdenv.mkDerivation rec {
  pname = "rcw";
  version = "LSDK-19.09";

  src = fetchgit {
    url = "https://source.codeaurora.org/external/qoriq/qoriq-components/rcw";
    rev = "refs/tags/${version}";
    sha256 = "1c36p2r2pldzakqqjrxwnil6637nsccdfc7sh1bq29b6l8s8z37g";
  };

  patches = [
    ../patches/rcw/0001-lx2160acex7-misc-RCW-files.patch
    ../patches/rcw/0002-Set-io-pads-as-GPIO.patch
    ../patches/rcw/0003-S2-enable-gen3-xspi-increase-divisor-to-28.patch
  ];

  nativeBuildInputs = [ python3 ];

  preBuild = ''
    cd lx2160acex7
  '';

  installPhase = ''
    mkdir -p $out/lx2160acex7/XGGFF_PP_HHHH_RR_19_5_2
    cp -v XGGFF_PP_HHHH_RR_19_5_2/*.bin $out/lx2160acex7/XGGFF_PP_HHHH_RR_19_5_2
  '';
}
