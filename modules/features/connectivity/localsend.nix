{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.localsend = {pkgs, ...}: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
    #environment.systemPackages = [pkgs.jocalsend];
  };
}
