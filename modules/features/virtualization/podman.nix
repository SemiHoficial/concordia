{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.podman = {
    pkgs,
    config,
    ...
  }: {
    hardware.nvidia-container-toolkit.enable = true;

    virtualisation.podman = {
      enable = true;
      #autoPrune = true;

      dockerCompat = true;
      #dockerSocket.enable = true;
    };

    users.users.${config.preferences.user.name}.extraGroups = ["podman"];

    environment.systemPackages = [pkgs.podman-tui];
  };
}
