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
    src = pkgs.fetchFromGitHub {
      owner = "diinki";
      repo = "linux-antiquity";
      rev = "d071b0ca91a4e8185d8e78829ca56413cd496237";
      hash = pkgs.lib.fakeHash;
    };
  in {
    packages.linux-antiquity = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.hyprland;
      runtimeInputs = [
        pkgs.hyprpaper
        pkgs.quickshell
        pkgs.nemo
        pkgs.mako
        pkgs.socat
        pkgs.nwg-look
        pkgs.dconf
        pkgs.dconf-editor
        pkgs.kitty
        pkgs.qt6.qt5compat
        pkgs.qt5.qtgraphicaleffects
      ];
      flags = {
      };
      args = [
        "--config"
        "${src}/configs/hypr/hyprland.lua"
      ];
    };
  };
}
