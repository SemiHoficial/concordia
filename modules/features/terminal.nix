{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.terminal = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      self.nixosModules.environment
      #self.nixosModules.scripts
      self.nixosModules.appimage
    ];
    environment.systemPackages = [
      selfpkgs.ghostty
      pkgs.kitty
    ];
  };
  flake.nixosModules.environment = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      self.nixosModules.fish
      self.nixosModules.starship
    ];
    environment.systemPackages = [
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

      # wrapped packages
      selfpkgs.fastfetch
      selfpkgs.qalc
    ];
  };

  flake.nixosModules.fish = {
    pkgs,
    lib,
    host,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    programs.fish = {
      enable = true;
      shellAliases = {
        cat = "${lib.getExe pkgs.bat}"; # replace cat with bat
        cd = "z"; # replace cd with zoxide
        hs = "history | ${lib.getExe pkgs.fzf} | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"; # copies command from history
        hsr = "history | ${lib.getExe pkgs.fzf} | read -l cmd; and echo $cmd | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}; and eval $cmd"; # copies and runs command from history
        ls = "${lib.getExe pkgs.eza}";
        la = "${lib.getExe pkgs.eza} --icons -a --group-directories-first -1 --no-user --long";
        tree = "${lib.getExe pkgs.eza} --icons --tree --group-directories-first";
        nsh = "nix-shell -p ";
        tmp = "cd $(${lib.getExe' pkgs.uutils-coreutils-noprefix "mktemp"} -d)";
        copy = "${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
        man = "${lib.getExe pkgs.bat-extras.batman.out}";
        space = "${lib.getExe pkgs.dua} interactive";
        rebuild = "sudo nixos-rebuild switch --flake ~/concordia#${host}";
        rebuild-boot = "sudo nixos-rebuild boot --flake ~/concordia#${host}";
        fish_greeting = "${lib.getExe selfpkgs.fastfetch}";
      };
      shellInit = ''
        fish_vi_key_bindings
        set fish_bind_mode insert

        ${lib.getExe pkgs.zoxide} init fish | source
      '';
    };
    environment.systemPackages = with pkgs; [
      fishPlugins.autopair
      fishPlugins.bang-bang
      fishPlugins.bass
      fishPlugins.fzf-fish
      fishPlugins.done
      fishPlugins.fish-bd
      fishPlugins.puffer
    ];
  };

  flake.nixosModules.starship = {pkgs, ...}: {
    programs.starship = {
      enable = true;
      transientPrompt = {
        enable = false;
        #left = "";
        #right = "";
      };
      settings = {
        scan_timeout = 10;
        add_newline = false;
        character = {
          success_symbol = "[I❯](bold green)";
          error_symbol = "[I❯](bold red)";
          # vim symbols
          vimcmd_symbol = "[N❯](bold red)";
          vimcmd_replace_one_symbol = "[R❯](bold purple)";
          vimcmd_replace_symbol = "[R❯](bold purple)";
          vimcmd_visual_symbol = "[V❯](bold yellow)";
        };
        username = {
          format = "[$user]($style) ";
        };
      };
      presets = [
        "nerd-font-symbols"
      ];
    };
  };
}
