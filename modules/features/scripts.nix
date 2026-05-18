{self, ...}: {
  flake.nixosModules.scripts = {pkgs, ...}: {
    environment.systemPackages =
      builtins.attrValues self.packages.${pkgs.stdenv.hostPlatform.system};
  };

  perSystem = {pkgs, ...}: let
    scriptsDir = self + /modules/scripts;

    parseDeps = filename: let
      text = builtins.readFile (scriptsDir + "/${filename}");
      depLine =
        pkgs.lib.findFirst
        (pkgs.lib.hasPrefix "# nix-deps:")
        null
        (pkgs.lib.splitString "\n" text);
    in
      if depLine == null
      then []
      else
        map (n: pkgs.${n})
        (pkgs.lib.filter (n: n != "")
          (pkgs.lib.splitString " "
            (pkgs.lib.removePrefix "# nix-deps: " depLine)));

    # Build a shell script package from a .sh file
    makeShellPackage = filename:
      pkgs.writeShellApplication {
        name = pkgs.lib.removeSuffix ".sh" filename;
        runtimeInputs = parseDeps filename;
        text = builtins.readFile (scriptsDir + "/${filename}");
      };

    # Build a Rust script package from a .rs file using rust-script
    makeRustPackage = filename:
      pkgs.stdenv.mkDerivation {
        name = pkgs.lib.removeSuffix ".rs" filename;
        src = scriptsDir + "/${filename}";
        nativeBuildInputs = [pkgs.rust-script] ++ parseDeps filename;
        unpackPhase = "true";
        buildPhase = ''
          rust-script --package ${pkgs.lib.removeSuffix ".rs" filename} $src
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp $src $out/bin/${pkgs.lib.removeSuffix ".rs" filename}.rs
          cat > $out/bin/${pkgs.lib.removeSuffix ".rs" filename} <<EOF
          #!/usr/bin/env rust-script
          exec rust-script "$out/bin/${pkgs.lib.removeSuffix ".rs" filename}.rs" "\$@"
          EOF
          chmod +x $out/bin/${pkgs.lib.removeSuffix ".rs" filename}
        '';
      };

    allFiles = builtins.readDir scriptsDir;

    shPackages =
      builtins.mapAttrs
      (filename: _: makeShellPackage filename)
      (pkgs.lib.filterAttrs (n: _: pkgs.lib.hasSuffix ".sh" n) allFiles);

    rsPackages =
      builtins.mapAttrs
      (filename: _: makeRustPackage filename)
      (pkgs.lib.filterAttrs (n: _: pkgs.lib.hasSuffix ".rs" n) allFiles);

    scriptPackages = shPackages // rsPackages;
  in {
    packages = scriptPackages;
  };
}
