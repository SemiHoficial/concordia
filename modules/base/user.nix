{
  flake.nixosModules.kurwa = {lib, ...}: {
    options.prefer = {
      user.name = lib.mkOption {
        type = lib.types.str;
        default = "missy";
      };
    };
  };
}
