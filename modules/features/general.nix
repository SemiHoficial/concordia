{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.general = {
    pkgs,
    self',
    config,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      #self.nixosModules.extra_hjem
      #self.nixosModules.gtk
      self.nixosModules.nix
      self.nixosModules.security
    ];

    users.users.${config.prefer.user.name} = {
      isNormalUser = true;
      initialPassword = "1234";
      description = "Its ${config.prefer.user.name}!";
      extraGroups = ["wheel" "networkmanager"];
      shell = selfpkgs.environment;
    };

    programs.fish.enable = true;
    programs.fish.package = selfpkgs.environment;
  };
}
