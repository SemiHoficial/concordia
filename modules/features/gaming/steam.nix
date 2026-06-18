{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.steam = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.millennium.overlays.default];

    programs = {
      gamemode.enable = true;

      gamescope = {
        enable = true;

        #enableWsi = true;
      };

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

        extest.enable = true;

        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;

        extraCompatPackages = [
          pkgs.proton-ge-bin
        ];

        extraPackages = [
          pkgs.gamescope
        ];

        protontricks.enable = true;
      };
    };
    environment.systemPackages = [
      pkgs.steam-run
      pkgs.protonup-rs

      pkgs.mangohud
    ];
  };
}
