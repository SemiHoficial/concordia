{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.virtManager = {config, ...}: {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };

      spiceUSBRedirection.enable = true;
    };

    programs.virt-manager.enable = true;

    # environment.systemPackages = with pkgs; [
    #   virt-viewer
    #   spice
    #   spice-protocol
    # ];

    # taken from https://nixos.wiki/wiki/Virt-manager
    home-manager.users.${config.prefer.user.name}.dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    users.users.${config.prefer.user.name} = {
      extraGroups = ["libvirtd"];
    };
  };
}
