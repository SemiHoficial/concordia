{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.hyprland = {
    pkgs,
    ...
  }: {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;

      xwayland.enable = true;
      withUWSM = true;
    };
    programs.uwsm.enable = true;

    environment.systemPackages = [
      pkgs.hyprshot
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-shell
    ];
  };
}
