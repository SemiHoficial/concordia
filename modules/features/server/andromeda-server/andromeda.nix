{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.andromedaServer = {pkgs, ...}: {
    flux = {
      enable = true;
      servers.andromeda = {
        package = pkgs.mkMinecraftServer {
          name = "andromeda";
          src = ./mcman;
          hash = "sha256-NAMQWOhQ1lNtrJQO4JHVgr8UGLrDCkp8hn5HC/SLQB4=";
        };
        proxy.enable = true;
      };
    };
  };
}
