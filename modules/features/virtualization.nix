{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.virtualizationFull = {
    imports = [
      self.nixosModules.virtualization
      self.nixosModules.waydroid
      self.nixosModules.docker
      self.nixosModules.distrobox
    ];
  };
  flake.nixosModules.virtualization = {
    pkgs,
    config,
    ...
  }: {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };
      spiceUSBRedirection.enable = true;
    };
    environment.systemPackages = with pkgs; [
      qemu
      virt-manager
      virt-viewer
      spice
      spice-protocol
    ];

    users.users.${config.preferences.user.name} = {
      extraGroups = ["libvirtd"];
    };
  };

  flake.nixosModules.waydroid = {pkgs, ...}: {
    virtualisation.waydroid.enable = true;

    environment.systemPackages = [pkgs.waydroid-helper];
  };

  flake.nixosModules.docker = {
    pkgs,
    config,
    lib,
    ...
  }: {
    virtualisation.docker.enable = true;
    # hardware.nvidia-container-toolkit.enable =
    #   if config.preferences.graphics.nvidia
    #   then true
    #   else false;
    environment.systemPackages = [pkgs.docker-compose];
  };
  flake.nixosModules.distrobox = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.distrobox
      pkgs.distrobox-tui
    ];
  };
}
