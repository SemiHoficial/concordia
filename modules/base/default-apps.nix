{self, ...}: {
  flake.nixosModules.kurwa = {
    lib,
    config,
    ...
  }: {
    options.prefer = let
      home = "/home/${config.prefer.user.name}";
    in {
      defaultApps = {
        fileManager = lib.mkOption {
          type = lib.types.str;
          default = "dolphin.desktop";
        };

        imageViewer = lib.mkOption {
          type = lib.types.str;
          default = "imv.desktop";
        };

        videoPlayer = lib.mkOption {
          type = lib.types.str;
          default = "mpv.desktop";
        };

        audioPlayer = lib.mkOption {
          type = lib.types.str;
          default = "mpv.desktop";
        };

        browser = lib.mkOption {
          type = lib.types.str;
          default = "zen-beta.desktop";
        };

        pdfViewer = lib.mkOption {
          type = lib.types.str;
          default = "okular.desktop";
        };
      };
      #
    };
    imports = [self.nixosModules.homeManager];

    config = {
      home-manager.users.${config.prefer.user.name} = {
        xdg = {
          enable = true;
          mime.enable = true;
          mimeApps = let
            associations = {
              "inode/directory" = config.prefer.defaultApps.fileManager;

              "image/svg+xml" = config.prefer.defaultApps.imageViewer;
              "image/png" = config.prefer.defaultApps.imageViewer;
              "image/jpeg" = config.prefer.defaultApps.imageViewer;
              "image/*" = config.prefer.defaultApps.imageViewer;

              "video/*" = config.prefer.defaultApps.videoPlayer; # not working as expected...
              "video/x-matroska" = config.prefer.defaultApps.videoPlayer;
              "video/quicktime" = config.prefer.defaultApps.videoPlayer;
              "video/mp4" = config.prefer.defaultApps.videoPlayer;

              "audio/mpeg" = config.prefer.defaultApps.videoPlayer;
              "audio/*" = config.prefer.defaultApps.videoPlayer;

              "x-scheme-handler/http" = config.prefer.defaultApps.browser;
              "x-scheme-handler/https=" = config.prefer.defaultApps.browser;

              "application/pdf" = config.prefer.defaultApps.pdfViewer;
            };
          in {
            enable = true;
            associations.added = associations;
            defaultApplications = associations;
          };
        };
      };
    };
  };
}
