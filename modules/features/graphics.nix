{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.intel-graphics = {pkgs, ...}: {
    prefer.graphics.vaapi = true;
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          intel-vaapi-driver
          #intel-media-sdk
          libvdpau-va-gl
        ];

        extraPackages32 = with pkgs.pkgsi686Linux; [
          intel-vaapi-driver
        ];
      };

      enableRedistributableFirmware = true;
    };

    services.xserver.videoDrivers = ["modesetting"];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "i965";
    };
  };

  flake.nixosModules.nvidia = {
    prefer.graphics.nvidia = true;
    hardware.graphics = {
      enable = true;

      enable32Bit = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;

      #powerManagement.enable = true;

      open = true;

      nvidiaSettings = true;

      videoAcceleration = true;
    };
  };
}
