{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.terminal3d = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
      pname = "terminal3d";
      version = "0.1.0";

      src = pkgs.fetchFromGitHub {
        owner = "liam-ilan";
        repo = "terminal3d";
        tag = "v${finalAttrs.version}";
        hash = "sha256-gubfREoI/c3drNsFGUJ5i6QX9giMV0sAEUSIdslZoGA=";
      };

      cargoHash = "sha256-+krVtEdwLdUDGxvnzoeSqub2HENixVSumbugXqYGWtg=";

      nativeInstallCheckInputs = [pkgs.versionCheckHook];
      doInstallCheck = true;

      meta = with lib; {
        description = "View .obj files in the terminal 🦀";
        homepage = "https://github.com/liam-ilan/terminal3d";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "t3d";
      };
    });
  };
}
