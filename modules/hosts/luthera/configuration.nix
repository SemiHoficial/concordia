{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.luthera = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "luthera";
    };

    modules = [
      self.nixosModules.lutheraConfig
    ];
  };

  flake.nixosModules.lutheraConfig = {
    config,
    pkgs,
    host,
    ...
  }: {
    imports = [
      self.nixosModules.lutheraHardware
      self.nixosModules.boot
      self.nixosModules.network

      self.nixosModules.kurwa
      self.nixosModules.general
      self.nixosModules.sshd

      #self.nixosModules.virtualizationFull
      #self.nixosModules.ollama
      self.nixosModules.searx
    ];

    # --- network ---
    networking.firewall = {
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
      ];
    };

    # hardware.graphics = {
    #   enable = true;
    #   enable32Bit = true;
    # };

    environment.systemPackages = [
      pkgs.neovim
    ];

    system.stateVersion = "25.05";
  };
}
