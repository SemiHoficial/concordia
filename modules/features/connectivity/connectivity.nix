{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.connectivity = {
    imports = [
      self.nixosModules.localsend
      self.nixosModules.kde-connect
    ];
  };
}
