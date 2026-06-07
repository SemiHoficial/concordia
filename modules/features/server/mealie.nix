{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mealie = {
    services.mealie = {
      enable = true;
      port = 10100;
    };
  };
}
