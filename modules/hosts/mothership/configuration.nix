{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.mothership = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "mothership";
      pkgs-stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };

    modules = [
      self.nixosModules.mothershipConfig
      {
        nixpkgs.overlays = [
          inputs.flux.overlays.default
          inputs.nix-cachyos-kernel.overlays.pinned
        ];
      }
      inputs.flux.nixosModules.default
    ];
  };

  flake.nixosModules.mothershipConfig = {
    config,
    pkgs,
    host,
    ...
  }: {
    imports = [
      self.nixosModules.mothershipHardware
      self.nixosModules.boot
      self.nixosModules.network

      self.nixosModules.kurwa
      self.nixosModules.general
      self.nixosModules.desktop
      self.nixosModules.sddm

      self.nixosModules.nvidia
      self.nixosModules.sshd
      self.nixosModules.bluetooth
      self.nixosModules.keymap
      self.nixosModules.connectivity
      self.nixosModules.lan-mouse
      self.nixosModules.vicinae

      self.nixosModules.qbittorrent

      self.nixosModules.virtualization
      #self.nixosModules.searx

      self.nixosModules.gaming

      self.nixosModules.hyprland
      # self.nixosModules.kdePlasma

      #self.nixosModules.andromedaServer
    ];

    nixpkgs.config.allowUnfree = true;

    hardware.bluetooth.settings.General.FastConnectible = true;

    services.dbus.implementation = "broker";

    users.users.${config.prefer.user.name}.extraGroups = ["i2c" "milkyway"];

    # mount hdd milkyway
    fileSystems."/mnt/milkyway" = {
      device = "/dev/disk/by-uuid/e0868b55-28f5-4b72-b7ca-3486b03c2ac0";
      fsType = "ext4";
      options = [
        "nofail" # learned from experience to add this >.<
        "uid=missy"
        "gid=milkyway"
        "umask=002"
      ];
    };
    # qbittorrent access to milkyway
    users.users.qbittorrent.extraGroups = ["milkyway"];

    # --- network ---
    networking.firewall = {
      allowedTCPPorts = [
        8096
        3004
      ];
      allowedUDPPorts = [
        8096
      ];
    };

    #services.mealie = {
    #  enable = true;
    #  settings = {
    #    ALLOW_SIGNUP = "true";
    #  };
    #};

    #    users.users."lucas" = {
    #      isNormalUser = true;
    #      initialPassword = "1234";
    #      description = "Its lucas!";
    #      extraGroups = ["networkmanager"];
    #      shell = pkgs.fish;
    #    };

    nixpkgs.overlays = [
      (final: prev: {
        openldap = prev.openldap.overrideAttrs (old: {
          doCheck = false;
        });
      })
    ];

    hardware.i2c.enable = true; # for ddcutil

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = [
      pkgs.ddcutil # monitor settings control
      pkgs.ddcui # ui for ddcutil
      pkgs.neovim

      pkgs.godot # game engine

      #     pkgs.krita # painting

      pkgs.pixelorama # pixel art

      pkgs.obs-studio # recording
      pkgs.kdePackages.kdenlive # video editing
      pkgs.davinci-resolve # also video editing but a bit goofy on linux

      pkgs.kicad # electronics design cad
    ];

    system.stateVersion = "25.05";
  };
}
