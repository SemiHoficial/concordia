{
  flake.nixosModules.kurwa = {
    pkgs,
    lib,
    ...
  }: {
    options.preferences = {
      user.name = lib.mkOption {
        type = lib.types.str;
        default = "missy";
      };

      plymouthTheme = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "blahaj";
        };
        packages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [pkgs.plymouth-blahaj-theme];
        };
      };

      sddmTheme = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "sddm-astronaut-theme";
        };
        packages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [
            (pkgs.sddm-astronaut.override {
              embeddedTheme = "japanese_aesthetic";
              themeConfig = {
                ScreenWidth = "1920";
                ScreenHeight = "1080";
                HeaderText = "Ad Andromeda";
              };
            })
          ];
        };
      };

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
