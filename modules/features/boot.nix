{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.boot = {
    pkgs,
    pkgsUnstable,
    config,
    ...
  }: {
    boot = {
      #kernelPackages = pkgsUnstable.linuxKernel.packages.linux_zen;
      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-x86_64-v3;

      loader = {
        systemd-boot = {
          enable = true;
        };
        efi.canTouchEfiVariables = true;
      };

      plymouth = {
        enable = true;
        themePackages = config.prefer.theme.plymouth.packages;
        theme = config.prefer.theme.plymouth.name;
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
