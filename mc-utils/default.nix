{ stdenv, lib, fetchgit, dtc }:

stdenv.mkDerivation rec {
  pname = "mc-utils";
  version = "LSDK-19.09";

  src = fetchgit {
    url = "https://source.codeaurora.org/external/qoriq/qoriq-components/${pname}";
    rev = version;
    sha256 = "0xljcnzqhd233h21q1rgndj1wh1ybyw1xw4f9k9gs2mn7inlsg6n";
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
