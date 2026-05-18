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
  flake.nixosModules.localsend = {pkgs, ...}: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
    environment.systemPackages = [pkgs.jocalsend];
  };
  flake.nixosModules.kde-connect = {pkgs, ...}: {
    programs.kdeconnect.enable = true;
  };
  flake.nixosModules.lan-mouse = {
    pkgs,
    config,
    ...
  }: {
    home-manager.users.${config.preferences.user.name} = {pkgs, ...}: {
      imports = [inputs.lan-mouse.homeManagerModules.default];
      programs.lan-mouse = {
        enable = true;
        systemd = true;
        # package = inputs.lan-mouse.packages.${pkgs.stdenv.hostPlatform.system}.default
        # Optional configuration in nix syntax, see config.toml for available options
        settings = {
          "release_bind" = ["KeyA" "KeyS" "KeyD" "KeyF"];
          port = 4242;
          "authorized_fingerprints" = {
            "5b:76:a8:c3:c7:94:7c:ab:89:7c:f2:35:d6:93:a3:0c:65:98:8c:b4:74:db:9f:42:a5:9e:23:6a:4a:c5:a1:c4" = "elowen";
            "21:2d:29:c9:f2:e1:4c:6e:46:5d:77:63:ad:3b:7a:9a:62:cd:a3:f4:6a:5f:ca:22:63:00:6d:d4:85:84:2d:50" = "mothership";
          };
          clients = [
            {
              position = "down";
              hostname = "elowen";
              activate_on_startup = true;
              ips = [
                "192.168.1.126"
                "192.168.1.119"
              ];
            }
            {
              position = "up";
              hostname = "mothership";
              activate_on_startup = true;
              ips = ["192.168.1.107"];
            }
          ];
        };
      };
    };
  };
}
