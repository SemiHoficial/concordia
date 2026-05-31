{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    packages.terminal = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = selfpkgs.ghostty;

      args = [
        "-e"
        "${lib.getExe selfpkgs.environment}"
      ];
    };

    packages.environment = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = selfpkgs.fish;

      runtimeInputs = [
        # nix
        pkgs.nil
        pkgs.nixd
        pkgs.statix
        pkgs.alejandra
        pkgs.manix
        pkgs.nix-inspect
        selfpkgs.nh

        # other
        pkgs.file
        pkgs.unzip
        pkgs.zip
        pkgs.unrar-free
        pkgs.p7zip
        pkgs.wget
        pkgs.killall
        pkgs.sshfs
        pkgs.fzf
        pkgs.htop
        pkgs.btop
        pkgs.eza
        pkgs.bat # cat replacement
        pkgs.bat-extras.batman.out # man replacement
        pkgs.wiki-tui
        pkgs.tealdeer
        pkgs.speedtest-rs
        pkgs.jq
        pkgs.fd # find
        pkgs.zoxide # cd replacement
        pkgs.dua
        pkgs.ripgrep
        pkgs.ripgrep-all
        pkgs.tree-sitter
        pkgs.imv
        pkgs.f3d
        selfpkgs.terminal3d # terminal 3D model viewer
        pkgs.imagemagick
        pkgs.ffmpeg-full
        pkgs.yt-dlp
        pkgs.yazi

        pkgs.gitui
        pkgs.git
        pkgs.gh

        pkgs.usbutils # lsusb
        pkgs.songrec # shazam
        pkgs.tesseract # image to text
        pkgs.uutils-coreutils-noprefix # rust coreutils replacement

        pkgs.kitty # backup terminal

        # wrapped packages
        selfpkgs.fastfetch
        selfpkgs.qalc
      ];
      env = {
        EDITOR = lib.getExe pkgs.neovim;
      };
    };
  };
}
