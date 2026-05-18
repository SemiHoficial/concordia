{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.mpv-webtorrent-hook = pkgs.stdenvNoCC.mkDerivation {
      pname = "mpv-webtorrent-hook";
      version = "0-unstable-2026-02-20";

      src = pkgs.fetchFromGitHub {
        owner = "noctuid";
        repo = "mpv-webtorrent-hook";
        rev = "8d6f5d3863693cb0d34fcfbdb4582ebcd1b5ca65";
        hash = "sha256-VXzamrLWWsEdydsgP6nzYrMs48wD17fjLhGST20X+pU=";
      };

      dontBuild = true;

      installPhase = ''
        mkdir -p $out/share/mpv/scripts/webtorrent-hook
        cp -r $src/. $out/share/mpv/scripts/webtorrent-hook/
      '';
      passthru.scriptName = "webtorrent-hook";

      meta = with pkgs.lib; {
        description = "Stream torrents in mpv using webtorrent-cli";
        homepage = "https://github.com/noctuid/mpv-webtorrent-hook";
        license = licenses.gpl3Only;
        platforms = platforms.linux;
      };
    };
  };
}
