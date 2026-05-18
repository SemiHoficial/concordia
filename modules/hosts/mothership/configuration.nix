{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.mothership = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "mothership";
      pkgsUnstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };

    modules = [
      self.nixosModules.mothershipConfig
    ];
  };

  flake.nixosModules.mothershipConfig = {
    config,
    pkgs,
    pkgsUnstable,
    host,
    ...
  }: let
    blender-cuda = pkgsUnstable.blender.override {
      cudaSupport = true;
    };
  in {
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

      self.nixosModules.virtualizationFull
      self.nixosModules.searx

      self.nixosModules.gaming

      self.nixosModules.hyprland
      #self.nixosModules.kdePlasma
    ];

    nixpkgs.config.allowUnfree = true;

    hardware.bluetooth.settings.General.FastConnectible = true;

    services.dbus.implementation = "dbus";

    users.users.${config.preferences.user.name}.extraGroups = ["i2c" "docker"];

    # --- network ---
    networking.firewall = {
      allowedTCPPorts = [
        4242
        8096
      ];
      allowedUDPPorts = [
        4242
        8096
      ];
    };

    users.users."lucas" = {
      isNormalUser = true;
      initialPassword = "1234";
      description = "Its lucas!";
      extraGroups = ["networkmanager"];
      shell = pkgs.fish;
    };

    # mount hdd milkyway
    fileSystems."/mnt/milkyway" = {
      device = "/dev/disk/by-uuid/e0868b55-28f5-4b72-b7ca-3486b03c2ac0";
      fsType = "ext4";
      options = [
        "nofail" # learned from experience to add this >.<
      ];
    };

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

      blender-cuda # 3d modelling, cuda version cuz nvidia

      pkgsUnstable.godot # game engine

      pkgs.krita # painting

      pkgs.pixelorama # pixel art

      pkgs.obs-studio # recording
      pkgsUnstable.kdePackages.kdenlive # video editing
      pkgsUnstable.davinci-resolve # also video editing but a bit goofy on linux

      pkgsUnstable.kicad # electronics design cad
    ];

    system.stateVersion = "25.05";
  };
}
