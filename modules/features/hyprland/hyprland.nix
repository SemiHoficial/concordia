{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.hyprland = {
    pkgs,
    pkgsUnstable,
    ...
  }: {
    programs.hyprland = {
      enable = true;
      package = pkgsUnstable.hyprland;
      portalPackage = pkgsUnstable.xdg-desktop-portal-hyprland;

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
