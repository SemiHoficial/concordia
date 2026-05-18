{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.flatpak = {pkgs, ...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

    services.flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
      ];
    };
  };
}
