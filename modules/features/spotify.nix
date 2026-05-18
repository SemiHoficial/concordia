{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.spotify = {pkgs, ...}: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    imports = [inputs.spicetify-nix.nixosModules.spicetify];

    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        groupSession
        seekSong
        skipStats
        wikify
        history
        lastfm
        playNext
        copyLyrics
        queueTime
        aiBandBlocker
        sessionStats
      ];
      theme = spicePkgs.themes.comfy;
    };
  };
}
