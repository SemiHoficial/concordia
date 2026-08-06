{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.missy-paintings = pkgs.stdenvNoCC.mkDerivation {
      pname = "missy-paintings";
      version = "1.0";

      src = pkgs.fetchFromGitHub {
        owner = "SemiHoficial";
        repo = "missy-paintings";
        rev = "3fe95174ac78c46dedd9be58e5c6d94df2d7cdda";
        hash = "sha256-uVOjFL97zzvtk4NobR/uJ3XXU4iJgdpBjjpodhrz1Tg=";
      };

      nativeBuildInputs = [pkgs.imagemagick];

      installPhase = ''
        mkdir -p $out/original
        mkdir -p $out/scaled

        cp $src/original/*.png $out/original

        for file in $src/original/*.png; do
          # Uppercase First Letter
          newname=$(basename "''${file%.png}" | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g')

          # scale nearest neighbour
          magick "$file" \
            -scale 1024x1024 \
            "$out/scaled/''${newname}.png"
        done
      '';
    };
  };
}
