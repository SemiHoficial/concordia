{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.fonts = {pkgs, ...}: {
    fonts.fontDir.enable = true;
    fonts.packages = [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.ubuntu-sans
      pkgs.cm_unicode
      pkgs.corefonts
      pkgs.unifont
      pkgs.carlito
    ];
  };
}
