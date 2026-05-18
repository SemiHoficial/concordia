{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      #self.nixosModules.gtk

      self.nixosModules.pipewire
      self.nixosModules.terminal
      self.nixosModules.discord
      self.nixosModules.zenBrowser
      self.nixosModules.flatpak
      self.nixosModules.mpv
      self.nixosModules.spotify
      self.nixosModules.localsend
      self.nixosModules.xserver
    ];

    programs.niri = {
      enable = true;
      package = selfpkgs.niri;
    };

    services.libinput.enable = true;

    environment.systemPackages = [
      pkgs.kdePackages.dolphin-plugins
      pkgs.kdePackages.gwenview
      pkgs.kdePackages.dolphin
      pkgs.kdePackages.okular
      pkgs.kdePackages.kate
      pkgs.kdePackages.ark

      pkgs.pwvucontrol

      pkgs.wl-clipboard
      pkgs.vlc

      pkgs.obsidian

      selfpkgs.helium-browser
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
      cm_unicode
      corefonts
      unifont
    ];

    time.timeZone = "Europe/Bucharest";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ro_RO.UTF-8";
      LC_IDENTIFICATION = "ro_RO.UTF-8";
      LC_MEASUREMENT = "ro_RO.UTF-8";
      LC_MONETARY = "ro_RO.UTF-8";
      LC_NAME = "ro_RO.UTF-8";
      LC_NUMERIC = "ro_RO.UTF-8";
      LC_PAPER = "ro_RO.UTF-8";
      LC_TELEPHONE = "ro_RO.UTF-8";
      LC_TIME = "ro_RO.UTF-8";
    };
    /*
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        quickPhrase = {
          smile = "（・∀・）";
          angry = "(￣ー￣)";
        };
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
          kdePackages.fcitx5-qt
          fcitx5-mellow-themes
        ];
      };
    };
    */
    services.xserver.xkb = {
      layout = "us,jp,ro";
      variant = "";
    };
    environment.variables = {
    };

    security.polkit.enable = true;

    hardware = {
      enableAllFirmware = true;

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
