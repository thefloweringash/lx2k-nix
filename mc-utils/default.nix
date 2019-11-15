{ stdenv, lib, fetchgit, dtc }:

stdenv.mkDerivation rec {
  pname = "mc-utils";
  version = "LSDK-19.06";

  src = fetchgit {
    url = "https://source.codeaurora.org/external/qoriq/qoriq-components/${pname}";
    rev = version;
    sha256 = "10akc3x24af8x1zq1bfg6rq32gy2aax13zg2hn72qpacwkf11791";
  };

  patches = [
    ../patches/mc-utils/0001-lx2160acex7-add-8x10G-dual-40G-and-dual-100G-DPL-DPC.patch
  ];

  nativeBuildInputs = [ dtc ];

  preBuild = ''
    cd config
  '';

  installPhase = ''
    mkdir -p $out/config/lx2160a/CEX7
    cp -v \
      --target-directory $out/config/lx2160a/CEX7 \
      lx2160a/CEX7/*.dtb
  '';
}
