{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.boot = {
    pkgs,
    config,
    ...
  }: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      loader = {
        systemd-boot = {
          enable = true;
        };
        efi.canTouchEfiVariables = true;
      };

      plymouth = {
        enable = true;
        themePackages = config.preferences.plymouthTheme.packages;
        theme = config.preferences.plymouthTheme.name;
      };
      # silent boot
      #consoleLogLevel = 3;
      #initrd.verbose = false;
      kernelParams = [
        "quiet"
        #"udev.log_level=3"
        #"systemd.show_status=auto"
      ];
      #loader.timeout = 0;

      kernelModules = [
        "coretemp"
      ];
    };
  };
}
