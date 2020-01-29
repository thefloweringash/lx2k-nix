{ stdenv, lib, fetchFromGitHub, atf }:

stdenv.mkDerivation rec {
  name = "ddr-phy-bin";
  version = "LSDK-19.09";

  src = fetchFromGitHub {
    owner = "NXP";
    repo = "ddr-phy-binary";
    rev = version;
    sha256 = "0z6h8cb7ms0vhdrwbhk79cnmibvvk8y912qds57c0rs5i95z11rs";
  };

  nativeBuildInputs = [ atf ];

  buildPhase = ''
    fiptool create \
      --ddr-immem-udimm-1d lx2160a/ddr4_pmu_train_imem.bin \
      --ddr-immem-udimm-2d lx2160a/ddr4_2d_pmu_train_imem.bin \
      --ddr-dmmem-udimm-1d lx2160a/ddr4_pmu_train_dmem.bin \
      --ddr-dmmem-udimm-2d lx2160a/ddr4_2d_pmu_train_dmem.bin \
      --ddr-immem-rdimm-1d lx2160a/ddr4_rdimm_pmu_train_imem.bin \
      --ddr-immem-rdimm-2d lx2160a/ddr4_rdimm2d_pmu_train_imem.bin \
      --ddr-dmmem-rdimm-1d lx2160a/ddr4_rdimm_pmu_train_dmem.bin \
      --ddr-dmmem-rdimm-2d lx2160a/ddr4_rdimm2d_pmu_train_dmem.bin \
      fip_ddr_all.bin
  '';

  installPhase = ''
    mkdir $out
    cp -v fip_ddr_all.bin $out
  '';
}
