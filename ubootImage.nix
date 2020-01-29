{ runCommand, lib, uboot, atf, ddr-phy-bin, qoriq-mc-bin, mc-utils }:

let
  serdes = atf.serdes;

  inherit (
    if lib.hasPrefix "13_" serdes then
      { dpc = "dpc-dual-100g.dtb"; dpl = "dpl-eth.dual-100g.19.dtb"; }
    else if lib.hasPrefix "8_" serdes then
      { dpc = "dpc-8_x_usxgmii.dtb"; dpl = "dpl-eth.8x10g.19.dtb"; }
    else if lib.hasPrefix "20_" serdes then
      { dpc = "dpc-dual-40g.dtb"; dpl = "dpl-eth.dual-40g.19.dtb"; }
    else (throw "Unexpected serdes value")
  ) dpl dpc;
in

runCommand "uboot-image" {

} ''
  mkdir $out
  img=$out/uboot.img
  truncate -s 64M $img

  copyto() {
    local offset=$1
    local source=$2
    dd if=$source of=$img bs=512 seek=$(( offset )) conv=notrunc
  }

  # RCW+PBI+BL2 at block 8
  copyto 8      ${atf}/lx2160acex7/bl2_${atf.atfBoot}.pbl

  # PFE firmware at 0x100

  # FIP (BL31+BL32+BL33) at 0x800
  copyto 0x800  ${atf}/lx2160acex7/fip.bin

  # DDR PHY FIP at 0x4000
  copyto 0x4000 ${ddr-phy-bin}/fip_ddr_all.bin

  # Env variables at 0x2800

  # Secureboot headers at 0x3000

  # DPAA1 FMAN ucode at 0x4800

  # DPAA2-MC at 0x5000
  copyto 0x5000 ${qoriq-mc-bin}/lx2160a/mc_10.18.0_lx2160a.itb

  # DPAA2 DPL at 0x6800
  copyto 0x6800 ${mc-utils}/config/lx2160a/CEX7/${dpl}

  # DPAA2 DPC at 0x7000
  copyto 0x7000 ${mc-utils}/config/lx2160a/CEX7/${dpc}

  # Kernel at 0x8000

  # Ramdisk at 0x10000
''
