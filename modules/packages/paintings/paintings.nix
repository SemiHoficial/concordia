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
        rev = "60bb9065fda972916795a389f46730a92869fb7a";
        hash = "sha256-BsuI25fWqhp5+R1mI7F0TOU4QU5rQg/TbYGFpHBSgv0=";
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
