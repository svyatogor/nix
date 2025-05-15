{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "DankMono";
  dontConfigure = true; # Corrected typo from dontConfigue
  nativeBuildInputs = [ pkgs.unzip ];
  buildInputs = [ pkgs.unzip ];
  src = ../assets/DankMono.zip;
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r OpenType-TT/* $out/share/fonts/truetype
  '';
}
