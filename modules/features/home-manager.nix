{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.homeManager = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      inputs.home-manager.nixosModules.default # import official home-manager NixOS module
    ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.prefer.user.name} = {
        home.stateVersion = "26.05";
        programs.home-manager.enable = true;
      };
    };
  };
}
