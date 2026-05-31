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
  }: {
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
      shell = pkgs.fish;
    };

    programs.fish.enable = true;
  };
}
