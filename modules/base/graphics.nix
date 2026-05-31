{
  flake.nixosModules.kurwa = {lib, ...}: {
    options.prefer = {
      graphics = {
        vaapi = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        nvidia = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
    };
  };
}
