{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.mpv-shaders = pkgs.stdenvNoCC.mkDerivation {
      pname = "mpv-shaders";
      version = "1.0";

      src = ./shaders;
      dontUnpack = true;
      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/mpv/shaders
        cp -r $src/. $out/share/mpv/shaders/

        runHook postInstall
      '';
    };
  };
}
