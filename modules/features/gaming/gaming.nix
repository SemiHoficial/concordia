{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.gaming = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.steam
    ];

    environment.systemPackages = with pkgs; [
      lutris

      dxvk
      # parsec-bin

      gamescope

      wine
      winetricks
      #r2modman

      heroic

      #er-patcher
      bottles

      steamtinkerlaunch

      prismlauncher
    ];
    services.flatpak.packages = [
      "net.veloren.airshipper"
      "org.vinegarhq.Sober"
    ];

    nix.settings = {
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
}
