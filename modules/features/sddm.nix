{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sddm = {
    pkgs,
    config,
    lib,
    ...
  }: {
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = config.prefer.theme.sddm.name;
          extraPackages = [
            pkgs.kdePackages.qtsvg
            pkgs.kdePackages.qtvirtualkeyboard
            pkgs.kdePackages.qtmultimedia
          ];
          settings = {
          };
        };
        #defaultSession = ""; # eg. niri, hyprland
      };
    };
    environment.systemPackages = config.prefer.theme.sddm.packages;
  };
}
