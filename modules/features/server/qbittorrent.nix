{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.qbittorrent = {
    services.qbittorrent = {
      enable = true;

      webuiPort = 8081;

      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences = {
          WebUI = {
            LocalHostAuth = false;
          };

          General.Locale = "en";
        };
      };
    };

    services.qui = {
      #enable = true;

      settings.port = 8111;
      #openFirewall = true;

      secretFile = "/run/secrets/qui-session.txt";

      settings = {
      };
    };

    #environment.systemPackages = [pkgs.qbittorrent-cli];
  };
}
