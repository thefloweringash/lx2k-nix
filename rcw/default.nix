{ stdenv, lib, fetchgit, python2 }:

stdenv.mkDerivation rec {
  pname = "rcw";
  version = "LSDK-19.06";

  src = fetchgit {
    url = "https://source.codeaurora.org/external/qoriq/qoriq-components/rcw";
    rev = "refs/tags/${version}";
    sha256 = "1wv8ml13ylm66f8rfni2nk0pijcnywbd0pd1fj3q43a17h652lw2";
  };

  patches = [
    ../patches/rcw/0001-lx2160acex7-misc-RCW-files.patch
    ../patches/rcw/0002-Set-io-pads-as-GPIO.patch
    ../patches/rcw/0003-S2-enable-gen3-xspi-increase-divisor-to-28.patch
  ];

  nativeBuildInputs = [ python2 ];

  preBuild = ''
    cd lx2160acex7
  '';

  installPhase = ''
    mkdir -p $out/lx2160acex7/XGGFF_PP_HHHH_RR_19_5_2
    cp -v XGGFF_PP_HHHH_RR_19_5_2/*.bin $out/lx2160acex7/XGGFF_PP_HHHH_RR_19_5_2
  '';
}
