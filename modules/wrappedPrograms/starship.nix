{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    starshipConfig = pkgs.writeText "starship.toml" ''
      "$schema" = 'https://starship.rs/config-schema.json'
      scan_timeout = 10
      add_newline = false

      [character]
      success_symbol = "[I❯](bold green)"
      error_symbol = "[I❯](bold red)"
      vimcmd_symbol = "[N❯](bold red)"
      vimcmd_replace_one_symbol = "[R❯](bold purple)"
      vimcmd_replace_symbol = "[R❯](bold purple)"
      vimcmd_visual_symbol = "[V❯](bold yellow)"

      [username]
      format = "[$user]($style) "
    '';
  in {
    packages.starship = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.starship;

      env = {
        STARSHIP_CONFIG = "${starshipConfig}";
      };
    };
  };
}
