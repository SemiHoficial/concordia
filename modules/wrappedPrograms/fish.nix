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
    mkFish = let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";

      fishConfig = pkgs.writeText "fish-config.conf" ''
        fish_vi_key_bindings
        set fish_bind_mode insert

        ${lib.getExe pkgs.zoxide} init fish | source

        function starship_transient_prompt_func
          starship module character
        end
        ${lib.getExe selfpkgs.starship} init fish | source
        enable_transience

        alias unrar="${lib.getExe pkgs.unrar-free}" # easier to type
        alias cat="${lib.getExe pkgs.bat} -p"; # replace cat with bat
        alias cd="z"; # replace cd with zoxide
        alias ls="${lib.getExe pkgs.eza}";
        alias la="${lib.getExe pkgs.eza} --icons -a --group-directories-first -1 --no-user --long";
        alias lu="${lib.getExe pkgs.eza} --icons -a --group-directories-first -1 --long";
        alias tree="${lib.getExe pkgs.eza} --icons --tree --group-directories-first";
        alias nsh="nix-shell -p ";
        alias tmp="cd $(${lib.getExe' pkgs.uutils-coreutils-noprefix "mktemp"} -d)";
        alias copy="${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
        alias man="${lib.getExe pkgs.bat-extras.batman.out}";
        alias space="${lib.getExe pkgs.dua} interactive";
        alias rebuild="sudo nixos-rebuild switch --flake ~/concordia#$(hostname)";
        alias rebuild-boot="sudo nixos-rebuild boot --flake ~/concordia#$(hostname)";
        alias fish_greeting="${lib.getExe selfpkgs.fastfetch}";
      '';
    in
      inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.fish;

        runtimeInputs = [
          pkgs.fishPlugins.autopair
          pkgs.fishPlugins.bang-bang
          pkgs.fishPlugins.bass
          pkgs.fishPlugins.fzf-fish
          pkgs.fishPlugins.done
          pkgs.fishPlugins.fish-bd
          pkgs.fishPlugins.puffer

          selfpkgs.starship
        ];
        flags = {
          "-C" = "source ${fishConfig}";
        };
      };
  in {
    packages.fish = mkFish;
  };
}
