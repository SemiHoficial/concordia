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
    ];

    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      initialPassword = "1234";
      description = "Its ${config.preferences.user.name}!";
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.fish;
    };

    programs.fish.enable = true;
  };
}
