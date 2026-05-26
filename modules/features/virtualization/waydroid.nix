{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.waydroid = {pkgs, ...}: {
    virtualisation.waydroid.enable = true;

    environment.systemPackages = [pkgs.waydroid-helper];
  };
}
