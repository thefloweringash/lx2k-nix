{ lib, fetchFromGitHub }:

fetchFromGitHub {
  owner = "NXP";
  repo = "qoriq-mc-binary";
  rev = "LSDK-19.06";
  sha256 = "036h45hzc0ndlknq8iwzzym6yszhzadx3f87zpwbzjivfnp2n3n1";
}
