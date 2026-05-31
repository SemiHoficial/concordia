{
  flake.nixosModules.kurwa = {
    pkgs,
    lib,
    ...
  }: {
    options.prefer = {
      theme = {
        plymouth = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "blahaj";
          };
          packages = lib.mkOption {
            type = lib.types.listOf lib.types.package;
            default = [pkgs.plymouth-blahaj-theme];
          };
        };

        sddm = {
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
        #
      };
    };
  };
}
