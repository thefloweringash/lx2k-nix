{ buildUBoot, fetchgit, lib }:

buildUBoot {
  defconfig = "lx2160acex7_tfa_defconfig";
  filesToInstall = [ "u-boot.bin" ];

  src = fetchgit {
    url = "https://source.codeaurora.org/external/qoriq/qoriq-components/u-boot";
    rev = "refs/tags/LSDK-19.06";
    sha256 = "0kdr0j9axr61a6sgpdl2bsa6kzmqi1fzcc3dncjfg6l5hpgq65z5";
  };

  extraPatches = [
    ../patches/u-boot/0001-armv8-add-lx2160acex7-build-inclusion.patch
    ../patches/u-boot/0002-armv8-lx2160acex-misc-hacks-to-get-the-sources-built.patch
    ../patches/u-boot/0003-armv8-lx2160acex7-defconfig-and-main-platform-includ.patch
    ../patches/u-boot/0004-armv8-lx2160acex7-common-files-for-platform-support.patch
    ../patches/u-boot/0005-armv8-lx2160acex7-lx2160acex-device-tree.patch
    ../patches/u-boot/0006-armv8-lx2160acex7-board-support-files.patch
    ../patches/u-boot/0007-load-dpl-into-0x80001000-instead-of-0x80d00000.patch
    ../patches/u-boot/0008-uboot-add-nvme-commands-and-for-distroboot.patch
    ../patches/u-boot/0009-armv8-lx2160acex7-Fix-booting-from-NVMe-drives.patch
    ../patches/u-boot/0010-nvme-Fix-warning-of-cast-from-pointer-to-integer-of-.patch
    ../patches/u-boot/0011-nvme-Fix-PRP-Offset-Invalid.patch
    ../patches/u-boot/0012-nvme-add-accessor-to-namespace-id-and-eui64.patch
    ../patches/u-boot/0013-nvme-flush-dcache-on-both-r-w-and-the-prp-list.patch
    ../patches/u-boot/0014-nvme-use-page-aligned-buffer-for-identify-command.patch

    ./fix-defaults.patch
  ];
}
