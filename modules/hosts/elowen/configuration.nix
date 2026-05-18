{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.elowen = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "elowen";
    };

    modules = [
      self.nixosModules.elowenConfig
    ];
  };

  flake.nixosModules.elowenConfig = {
    config,
    pkgs,
    host,
    ...
  }: {
    imports = [
      self.nixosModules.elowenHardware
      self.nixosModules.boot
      self.nixosModules.network

      self.nixosModules.kurwa
      self.nixosModules.general
      self.nixosModules.desktop
      self.nixosModules.sddm

      self.nixosModules.intel-graphics
      self.nixosModules.sshd
      self.nixosModules.powersave
      self.nixosModules.bluetooth
      self.nixosModules.keymap
      self.nixosModules.lan-mouse
      self.nixosModules.vicinae
    ];

    # --- network ---
    networking.firewall = {
      allowedTCPPorts = [
        4242
      ];
      allowedUDPPorts = [
        4242
      ];
    };

    boot.extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';
    boot.kernelParams = ["i915.enable_guc=3"];

    environment.systemPackages = [pkgs.neovim];

    system.stateVersion = "25.05";
  };
}
