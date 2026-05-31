{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    cursor-shaders = pkgs.fetchFromGitHub {
      owner = "sahaj-b";
      repo = "ghostty-cursor-shaders";
      rev = "06d4e90fb5410e9c4d0b3131584060adddf89406";

      hash = "sha256-G/UIr1bKnxn1AcHl/4FL/jou6b7M2VeREslYVELxdmw=";
    };

    ghosttyConfig =
      pkgs.writeText "config.ghostty"
      ''
        custom-shader = ${cursor-shaders}/cursor_tail.glsl

        keybind = alt+1=goto_tab:1
        keybind = alt+2=goto_tab:2
        keybind = alt+3=goto_tab:3
        keybind = alt+4=goto_tab:4
        keybind = alt+5=goto_tab:5
        keybind = alt+6=goto_tab:6
        keybind = alt+7=goto_tab:7
        keybind = alt+8=goto_tab:8
        keybind = alt+9=goto_tab:9

        keybind = alt+tab=next_tab
        keybind = alt+shift+tab=previous_tab

        keybind = alt+t=new_tab
        keybind = alt+shift+w=close_tab

        shell-integration = fish
        shell-integration-features = true

        class = ghostty
      '';
  in {
    packages.ghostty = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.ghostty;
      flags = {
        "--config-file" = "${ghosttyConfig}";
      };
      flagSeparator = "=";
    };
  };
}
