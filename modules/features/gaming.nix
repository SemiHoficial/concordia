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
    ];
    nixpkgs.overlays = [inputs.millennium.overlays.default];

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        # package = pkgs.steam.override {
        #   extraProfile = ''
        #     unset TZ
        #     # Allows Monado/WiVRn to be used
        #     export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
        #   '';
        # };
        enable = true;
        package = pkgs.millennium-steam;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        # extraCompatPackages = with pkgs; [
        #   proton-ge-bin
        # ];
        # extraPackages = with pkgs; [
        #   SDL2
        #   gamescope
        #   er-patcher
        # ];
        protontricks.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      lutris
      steam-run
      protonup-rs
      dxvk
      # parsec-bin

      gamescope
      mangohud

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
