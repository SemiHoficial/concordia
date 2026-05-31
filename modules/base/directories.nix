{self, ...}: {
  flake.nixosModules.kurwa = {
    lib,
    config,
    ...
  }: {
    options.prefer = let
      home = "/home/${config.prefer.user.name}";
    in {
      images = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "${home}/pictures";
        };
        screenshotDir = lib.mkOption {
          type = lib.types.str;
          default = "${config.prefer.images.directory}/screenshots";
        };
      };

      videos = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "${home}/videos";
        };
        replayDir = lib.mkOption {
          type = lib.types.str;
          default = "${config.prefer.videos.directory}/replays";
        };
      };

      music = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "${home}/music";
        };
      };

      documents = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "${home}/documents";
        };
      };

      projects = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "${home}/projects";
        };
      };

      downloads = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "${home}/downloads";
        };
      };

      temp = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "/tmp";
        };
      };

      games = {
        directory = lib.mkOption {
          type = lib.types.str;
          default = "${home}/games";
        };
      };
      #
    };
    imports = [self.nixosModules.homeManager];

    config = {
      home-manager.users.${config.prefer.user.name} = let
        home = "/home/${config.prefer.user.name}";
      in {
        xdg = {
          enable = true;

          userDirs = {
            createDirectories = true;
            setSessionVariables = true;

            pictures = "${config.prefer.images.directory}";
            videos = "${config.prefer.videos.directory}";
            music = "${config.prefer.music.directory}";
            documents = "${config.prefer.documents.directory}";
            projects = "${config.prefer.projects.directory}";
            download = "${config.prefer.downloads.directory}";

            extraConfig = {
              GAMES = "${config.prefer.games.directory}";
            };
          };
        };
      };
    };
  };
}
