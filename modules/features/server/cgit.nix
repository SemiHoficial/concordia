{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.cgit = {
    services.cgit."main" = {
      enable = true;

      nginx.virtualHost = "localhost";

      scanPath = "/var/git";

      gitHttpBackend.checkExportOkFiles = false;
    };
  };
}
