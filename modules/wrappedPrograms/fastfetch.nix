{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    mkFastfetch = {logo ? ../../assets/fastfetch/howl.png, ...}: let
      logo = "${self.packages."${pkgs.stdenv.hostPlatform.system}".missy-paintings}/scaled/*.png";
      fastfetchConf =
        pkgs.writeText "fastfetchConf.jsonc"
        ''
          {
            "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
            "logo": {
              "type": "kitty-icat",
              "source": "${logo}",
              "height": 28,
              "width": 28,
              "padding": {
                "left": 1,
              },
            },
            "display": {
              "separator": " ",
            },
            "modules": [
              {
                "key": "╭───────────╮",
                "type": "custom",
              },
              {
                "key": "│ {#31} user    {#keys}│",
                "type": "title",
                "format": "{user-name}",
              },
              {
                "key": "│ {#32}󰇅 hname   {#keys}│",
                "type": "title",
                "format": "{host-name}",
              },
              {
                "key": "│ {#33}󰅐 uptime  {#keys}│",
                "type": "uptime",
              },
              {
                "key": "│ {#34}{icon} distro  {#keys}│",
                "type": "os",
              },
              {
                "key": "│ {#35} kernel  {#keys}│",
                "type": "kernel",
              },
              {
                "key": "│ {#36} wm      {#keys}│",
                "type": "wm",
              },
              {
                "key": "│ {#36}󰇄 desktop {#keys}│",
                "type": "de",
              },
              {
                "key": "│ {#31} term    {#keys}│",
                "type": "terminal",
              },
              {
                "key": "│ {#32} shell   {#keys}│",
                "type": "shell",
              },
              {
                "key": "│ {#33}󰍛 cpu     {#keys}│",
                "type": "cpu",
                "showPeCoreCount": true,
              },
              {
                "key": "│ {#33}󰍛 gpu     {#keys}│",
                "type": "gpu",
              },
              {
                "key": "│ {#34}󰉉 disk    {#keys}│",
                "type": "disk",
                "folders": "/",
              },
              {
                "key": "│ {#36} memory  {#keys}│",
                "type": "memory",
              },
              {
                "key": "├───────────┤",
                "type": "custom",
              },
              {
                "key": "│ {#39} colors  {#keys}│",
                "type": "colors",
                "symbol": "circle",
              },
              {
                "key": "╰───────────╯",
                "type": "custom",
              },
            ],
          }
        '';
    in
      inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.fastfetch;
        flags = {
          "--config" = "${fastfetchConf}";
        };
      };
  in {
    packages.fastfetch = pkgs.lib.makeOverridable mkFastfetch {};
  };
}
