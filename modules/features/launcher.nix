{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.vicinae = {config, ...}: {
    home-manager.users.${config.prefer.user.name} = {pkgs, ...}: {
      imports = [inputs.vicinae.homeManagerModules.default];

      services.vicinae = {
        enable = true;
        systemd = {
          enable = true;
          autoStart = true;
          environment = {
            USE_LAYER_SHELL = 1;
          };
        };
        settings = {
          close_on_focus_loss = true;
          search_files_in_root = true;
          theme = {
            light = {
              name = "noctalia";
              icon_theme = "default";
            };
            dark = {
              name = "noctalia";
              icon_theme = "default";
            };
          };
          launcher_window = {
            opacity = 0.9;
          };
        };
      };
    };
  };
}
