{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.appimage = {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
