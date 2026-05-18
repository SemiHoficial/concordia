{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.powersave = {
    pkgs,
    lib,
    ...
  }: {
    services = {
      thermald = {
        enable = true;
      };
      #tlp = {
      #  enable = true;
      #  settings = {
      #    START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      #    STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      #
      #    DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
      #
      #    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #    CPU_BOOST_ON_BAT = 0;
      #  };
      #};
      services.power-profiles-daemon.enable = true;
    };
  };
}
