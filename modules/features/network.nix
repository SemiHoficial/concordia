{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.network = {host, ...}: {
    networking = {
      hostName = host;

      networkmanager = {
        enable = true;
      };

      firewall.enable = true;
      firewall = {
        allowedTCPPorts = [
        ];
        allowedUDPPorts = [
        ];
      };
    };
  };
}
