{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kde-connect = {pkgs, ...}: {
    programs.kdeconnect.enable = true;
  };
}
