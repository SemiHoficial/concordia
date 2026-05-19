{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.mpv-shaders = pkgs.stdenvNoCC.mkDerivation {
      pname = "mpv-shaders";
      version = "1.0";

      ani4k = pkgs.fetchurl {
        url = "https://github.com/Sirosky/Upscale-Hub/releases/download/Ani4k-v2-ArtCNN/Ani4Kv2_ArtCNN_C4F32_i2.glsl";
        hash = "sha256-yS+r5ZkO2wWCuuAg4bHUcovBuy6L3EX2jX8slPGwRqs=";
      };
      ani4k_cmp = pkgs.fetchurl {
        url = "https://github.com/Sirosky/Upscale-Hub/releases/download/Ani4k-v2-ArtCNN/Ani4Kv2_ArtCNN_C4F32_i2_CMP.glsl";
        hash = "sha256-Yj22hYHlty/bMExuFJhCrcht8Wcx2NyDS6slBRr4w4s=";
      };
      anisd = pkgs.fetchurl {
        url = "https://github.com/Sirosky/Upscale-Hub/releases/download/AniSD-ArtCNN/AniSD_ArtCNN_C4F32_i4.glsl";
        hash = "sha256-d5C/E3IlD5tCmhmLi2A90LC4py7fdnAAO7Hfefyj1G0=";
      };
      anisd_cmp = pkgs.fetchurl {
        url = "https://github.com/Sirosky/Upscale-Hub/releases/download/AniSD-ArtCNN/AniSD_ArtCNN_C4F32_i4_CMP.glsl";
        hash = "sha256-7b4pZPIcK2NYjKF9xpNs7/CJkZsoXpvvJTE7iE5wBlU=";
      };

      dontUnpack = true;

      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/mpv/shaders
        cp $ani4k     $out/share/mpv/shaders/ani4K.glsl
        cp $ani4k_cmp $out/share/mpv/shaders/ani4K_cmp.glsl
        cp $anisd     $out/share/mpv/shaders/aniSD.glsl
        cp $anisd_cmp $out/share/mpv/shaders/aniSD_cmp.glsl
        runHook postInstall
      '';
    };
  };
}
