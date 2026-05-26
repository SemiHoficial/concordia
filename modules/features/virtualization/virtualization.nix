{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.virtualization = {
    imports = [
      self.nixosModules.virtManager
      self.nixosModules.distrobox
      self.nixosModules.waydroid
      self.nixosModules.podman
    ];
  };
}
