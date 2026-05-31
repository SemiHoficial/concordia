{
  flake.nixosModules.kurwa = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.prefer = {
    };
  };
}
