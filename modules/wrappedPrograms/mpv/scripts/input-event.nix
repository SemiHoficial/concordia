{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.mpv-input-event = pkgs.stdenvNoCC.mkDerivation {
      pname = "input-event";
      version = "1.3-unstable-2026-02-03";

      src = pkgs.fetchFromGitHub {
        owner = "natural-harmonia-gropius";
        repo = "input-event";
        rev = "8830e235a1ca43fb2bbe0cb858aa08275a981723";
        hash = "sha256-NWwDEOzrSVp7ZF9X2KruF+Db4se6WCsEiW2wz/UqpGI=";
      };

      dontBuild = true;

      installPhase = ''
        mkdir -p $out/share/mpv/scripts/
        cp -r $src/inputevent.lua $out/share/mpv/scripts/inputevent.lua
      '';
      passthru.scriptName = "inputevent.lua";

      meta = with pkgs.lib; {
        description = "Enhanced input.conf for mpv-player. with better, conflict-free, low-latency event mechanism.";
        homepage = "https://github.com/natural-harmonia-gropius/input-event";
        license = licenses.mit;
        platforms = platforms.linux;
      };
    };
  };
}
