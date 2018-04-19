# https://ariya.io/2016/06/isolated-development-environment-using-nix
# nix-shell --pure ariya.nix
with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    python
    python27Packages.virtualenv
    python27Packages.pip
    lua5_3
  ];
}
