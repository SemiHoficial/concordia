{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers.url = "github:lassulus/wrappers";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

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

    flux = {
      url = "github:IogaMaster/flux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos-cuda.org"
      "https://hyprland.cachix.org"
      "https://attic.xuyh0120.win/lantian"
    ];
    extra-trusted-substituters = [
      "https://cache.nixos-cuda.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (
      inputs.import-tree ./modules
    );
}
