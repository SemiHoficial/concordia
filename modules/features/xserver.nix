{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.xserver = {
    lib,
    config,
    ...
  }: {
    services = {
      xserver = {
        enable = true;
        videoDrivers = lib.mkIf config.preferences.graphics.nvidia ["nvidia"];
      };
    };
  };
}
