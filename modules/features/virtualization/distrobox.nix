{
  self,
  input,
  ...
}: {
  flake.nixosModules.distrobox = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.distrobox
      pkgs.distrobox-tui
    ];
  };
}
