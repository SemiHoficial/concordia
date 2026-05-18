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
      xwayland.enable = true;
    };

    environment.systemPackages = [
      pkgs.hyprshot
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-shell
    ];
  };
}
