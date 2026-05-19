{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wrappers.url = "github:lassulus/wrappers";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixcord.url = "github:FlameFlag/nixcord";

    millennium.url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    vicinae.url = "github:vicinaehq/vicinae";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    lan-mouse.url = "github:feschber/lan-mouse";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flux.url = "github:IogaMaster/flux";
    flux.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos-cuda.org"
    ];
    extra-trusted-substituters = [
      "https://cache.nixos-cuda.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (
      inputs.import-tree ./modules
    );
}
