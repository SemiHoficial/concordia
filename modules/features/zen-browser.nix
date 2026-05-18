{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.zenBrowser = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [self.nixosModules.homeManager];

    home-manager.users.${config.preferences.user.name} = {pkgs, ...}: {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      programs.zen-browser = {
        enable = true;
        profiles.default = {
          settings = {
            "zen.workspaces.continue-where-left-off" = true;
            "zen.view.compact.hide-tabbar" = true;
            "zen.urlbar.behavior" = "float";
            "zen.glance.enabled" = false;
            "zen.view.show-newtab-button-top" = false;
          };

          spacesForce = true; # Delete spaces not declared here
          spaces = {
            "Space" = {
              id = "c6de089c-410d-4206-961d-ab11f988d40a";
              position = 1000;
              icon = "🌌";
            };
            "Entertainment-District" = {
              id = "cdd10fab-4fc5-494b-9041-325e5759195b";
              position = 2000;
              icon = "🍿";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 100;
                    green = 150;
                    blue = 200;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
                opacity = 0.8;
                texture = 0.2;
              };
            };
            "Logging-Center" = {
              id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
              position = 3000;
              icon = "✒️";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 100;
                    green = 150;
                    blue = 200;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
                opacity = 0.8;
                texture = 0.2;
              };
            };
            "Admin-Station" = {
              id = "78aabdad-8aae-4fe0-8ff0-2a0c6as6cc24";
              position = 4000;
              icon = "💾";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 100;
                    green = 150;
                    blue = 200;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
                opacity = 0.8;
                texture = 0.2;
              };
            };
            "Inspiration-Gallery" = {
              id = "78aabdad-035j-4fe0-8ff0-2a0c6as6cc24";
              position = 6000;
              icon = "🖼️";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 100;
                    green = 150;
                    blue = 200;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
                opacity = 0.8;
                texture = 0.2;
              };
            };
            "Lab-Department" = {
              id = "78aa253d-035j-4fe0-8ff0-2a0c6as6cc24";
              position = 5000;
              icon = "🔬";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 100;
                    green = 150;
                    blue = 200;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
                opacity = 0.8;
                texture = 0.2;
              };
            };
            "Commerce-Station" = {
              id = "78aa253d-035j-4fe0-8ff0-h532sas6cc24";
              position = 7000;
              icon = "👛";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 100;
                    green = 150;
                    blue = 200;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
                opacity = 0.8;
                texture = 0.2;
              };
              container = 2;
            };
          };

          keyboardShortcutsVersion = 18;
          keyboardShortcuts = [
            {
              id = "zen-compact-mode-toggle";
              key = "s";
              modifiers.alt = true;
            }
            {
              id = "focusURLBar";
              key = " ";
              modifiers = {
                control = true;
              };
            }
            {
              id = "focusURLBar2";
              key = "p";
              modifiers = {
                control = true;
              };
            }
          ];

          search = {
            force = true; # Enforce declared search engines on each rebuild
            default = "ddg";
            engines = {
              youtube = {
                name = "Youtube";
                urls = [
                  {
                    template = "https://www.youtube.com/results?search_query={searchTerms}";
                  }
                ];
                definedAliases = ["y"];
              };
              nixsearch = {
                name = "Nix Search";
                urls = [
                  {
                    template = "https://search.nixos.org/packages?channel=unstable&include_modular_service_options=1&include_nixos_options=1&query={searchTerms}";
                    params = [
                      {
                        name = "query";
                        value = "searchTerms";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["n"];
              };
            };
          };

          containersForce = true;
          containers = {
            Personal = {
              color = "purple";
              icon = "fingerprint";
              id = 1;
            };
            Shopping = {
              color = "orange";
              icon = "dollar";
              id = 2;
            };
            Alternative = {
              color = "green";
              icon = "chill";
              id = 3;
            };
            Alternative-two = {
              color = "turquoise";
              icon = "chill";
              id = 4;
            };
          };
        };

        policies = let
          mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
          });
          lock-false = {
            value = false;
            status = "locked";
          };
          lock-true = {
            value = false;
            status = "locked";
          };
        in {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          PromptForDownloadLocation = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };

          preferences =
            {
              "browser.aboutConfig.showWarning" = lock-false;
              "privacy.resistFingerprinting" = lock-true;
              "privacy.resistFingerprinting.randomization.canvas.use_siphash" = lock-true;
              "privacy.resistFingerprinting.randomization.daily_reset.enabled" = lock-true;
              "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = lock-true;
              "privacy.resistFingerprinting.block_mozAddonManager" = lock-true;
              "privacy.spoof_english" = {
                value = 1;
                status = "locked";
              };
              "privacy.firstparty.isolate" = {
                value = true;
                status = "default";
              };
              "network.cookie.cookieBehavior" = 5;
              "dom.battery.enabled" = lock-false;
            }
            // lib.optionalAttrs config.preferences.graphics.vaapi {
              "media.ffmpeg.vaapi.enabled" = true;
            };

          mods = [
            "a6335949-4465-4b71-926c-4a52d34bc9c0" # floating find bar
            "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # hide scroll bar
          ];

          ExtensionSettings = mkExtensionSettings {
            "uBlock0@raymondhill.net" = "ublock-origin";
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
            "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}" = "view-page-archive"; # internet archives
            "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}" = "search_by_image"; # reverse image search
            "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = "traduzir-paginas-web"; # translate web pages
            "wayback_machine@mozilla.org" = "wayback-machine_new";
            "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = "user-agent-string-switcher";
            "{cf485034-0bda-470d-a027-794f3214359c}" = "youtube-shorts-redirect";
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
          };
        };
      };
    };
  };
}
