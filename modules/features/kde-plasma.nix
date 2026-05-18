{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kdePlasma = {
    services.desktopManager.plasma6.enable = true;
    services.desktopManager.plasma6.enableQt5Integration = false;
  };
}
