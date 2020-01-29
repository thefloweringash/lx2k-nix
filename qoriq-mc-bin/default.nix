{ lib, fetchFromGitHub }:

fetchFromGitHub {
  owner = "NXP";
  repo = "qoriq-mc-binary";
  rev = "LSDK-19.09";
  sha256 = "1h80vy1fgxl0in4bhhv5l6fch8fxbj0sypzdsaiiw8y52qkjsqlx";
}
