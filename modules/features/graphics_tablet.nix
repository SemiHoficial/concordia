{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.tablet = {pkgs, ...}: {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    environment.systemPackages = [pkgs.opentabletdriver];

    hardware.uinput.enable = true;
    boot.kernelModules = ["uinput"];
  };
}
