{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    mkMpv = {
      screenshotDir ? "~/Pictures/screenshots",
      videoDir ? "~/Videos",
      tempDir ? "/tmp",
    }: let
      mpvConfig = pkgs.linkFarm "mpv-config" (
        [
          {
            name = "mpv.conf";
            path = pkgs.writeText "mpv.conf" ''
              volume=80
              save-position-on-quit=yes
              sub-auto=fuzzy
              osd-bar=no
              #
              # Video driver to use. The latest gpu-next is recommended.
              vo=gpu-next
              gpu-api=vulkan
              hwdec=auto
              hwdec-codecs=all
              ###### High-quality screenshots
              screenshot-format=webp
              screenshot-webp-lossless=yes
              screenshot-high-bit-depth=yes
              screenshot-sw=no
              screenshot-directory="${screenshotDir}/mpv"
              screenshot-template="%f-%wH.%wM.%wS.%wT-#%#00n"
            '';
          }
          {
            name = "input.conf";
            path = pkgs.writeText "input.conf" ''
              # https://github.com/natural-harmonia-gropius/input-event
              WHEEL_UP   add volume   2
              WHEEL_DOWN add volume  -2
              RIGHT      seek   2 exact
              LEFT       seek  -2 exact
              UP         seek   5 exact
              DOWN       seek  -5 exact
              Ctrl+RIGHT seek  20 exact
              Ctrl+LEFT  seek -20 exact

              F1         add sub-delay -0.1	#event: click
              F2         add sub-delay +0.1	#event: click
              F5         no-osd screenshot

              alt+c script-message-to crop toggle-crop hard
              alt+e script-message-to encode set-timestamp encode_slice

              CTRL+1 no-osd change-list glsl-shaders clr ""; change-list glsl-shaders toggle "${self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-shaders}/share/mpv/shaders/ani4K.glsl";
              CTRL+2 no-osd change-list glsl-shaders clr ""; change-list glsl-shaders toggle "${self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-shaders}/share/mpv/shaders/ani4K_cmp.glsl";
              CTRL+3 no-osd change-list glsl-shaders clr ""; change-list glsl-shaders toggle "${self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-shaders}/share/mpv/shaders/aniSD.glsl";
              CTRL+4 no-osd change-list glsl-shaders clr ""; change-list glsl-shaders toggle "${self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-shaders}/share/mpv/shaders/aniSD_cmp.glsl";
              CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
            '';
          }
        ]
        ++ mpvScriptOpts {
          modernz = {
            jump_amount = "5";
            download_path = "${videoDir}";
            ontop_button = false;
            button_glow_amount = "2";
            fullscreen_button = false;
            seekbarfg_color = "#7b64ba";
            seekbarbg_color = "#7b64ba";
            hover_effect_color = "#a191cf";
            nibble_color = "#8970cd";
          };
          thumbfast = {
            network = true;
          };
          SmartCopyPaste_II = {
            linux_copy = "wl-copy";
            linux_paste = "wl-paste";
          };
          encode-mp4 = {
            only_active_tracks = true;
            preserve_filters = true;
            append_filter = "";
            codec = "c copy";
            output_format = "$f_$n.mp4";
            output_directory = "~/Videos";
            detached = true;
            ffmpeg_command = "ffmpeg";
            print = "true";
          };
          webtorrent-hook = {
            close_webtorrent = true;
            remove_files = true;
            webtorrent_flags = "['-d', '10000']";
            download_directory = "${tempDir}/mpv-webtorrent-download";
            show_speed = false;
            remember_last_played = true;
            remember_directory = "${tempDir}/mpv-webtorrent-remember";
          };
        }
      );

      mpvScriptOpts = opts:
        lib.mapAttrsToList (
          scriptName: scriptOpts: let
            lines =
              lib.mapAttrsToList (
                key: val: "${key}=${
                  if builtins.isBool val
                  then
                    (
                      if val
                      then "yes"
                      else "no"
                    )
                  else builtins.toString val
                }"
              )
              scriptOpts;
          in {
            name = "script-opts/${scriptName}.conf";
            path = pkgs.writeText "${scriptName}.conf" (lib.concatStringsSep "\n" lines);
          }
        )
        opts;
    in
      inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = (
          pkgs.mpv.override {
            mpv-unwrapped = pkgs.mpv-unwrapped.override {
              waylandSupport = true;
              ffmpeg = pkgs.ffmpeg-full;
            };
            scripts = [
              pkgs.mpvScripts.modernz # theme
              pkgs.mpvScripts.mpris # media controls
              pkgs.mpvScripts.thumbfast # thumbnails for seeking
              pkgs.mpvScripts.occivink.encode
              pkgs.mpvScripts.occivink.crop
              pkgs.mpvScripts.eisa01.smart-copy-paste-2 # copy paste anything
              pkgs.mpvScripts.eisa01.smartskip # keybinds = "> = next" "< = prev"
              self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-undo-redo
              self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-webtorrent-hook # torrent streaming
              self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-input-event
            ];
          }
        );
        runtimeInputs = [
          self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-shaders

          # --- webtorrent-hook dependencies ---
          self.packages.${pkgs.stdenv.hostPlatform.system}.webtorrent-cli
          pkgs.xidel
          pkgs.jq
          # ---
        ];
        flags = {
          "--config-dir" = "${mpvConfig}";
        };
        flagSeparator = "=";
      };
  in {
    packages.mpv = pkgs.lib.makeOverridable mkMpv {};
  };

  flake.nixosModules.mpv = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = [
      (self.packages.${pkgs.stdenv.hostPlatform.system}.mpv.override {
        screenshotDir = config.prefer.images.screenshotDir;
        videoDir = config.prefer.videos.directory;
        tempDir = config.prefer.temp.directory;
      })
    ];
  };
}
