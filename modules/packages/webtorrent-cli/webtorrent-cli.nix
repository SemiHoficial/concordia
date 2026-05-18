{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    nodeDatachannel = pkgs.buildNpmPackage {
      pname = "node-datachannel";
      version = "0.10.1";
      src = pkgs.fetchFromGitHub {
        owner = "murat-dogan";
        repo = "node-datachannel";
        tag = "v0.10.1";
        hash = "sha256-r5tBg645ikIWm+RU7Muw/JYyd7AMpkImD0Xygtm1MUk=";
      };
      npmFlags = ["--ignore-scripts"];
      makeCacheWritable = true;
      npmDepsHash = "sha256-1ZJd0Y45B3CT2YPXDYfCuFMBo5uggWRuDH11eCobyyY=";
      nativeBuildInputs = with pkgs; [cmake pkg-config];
      buildInputs = with pkgs; [openssl libdatachannel plog];
      dontUseCmakeConfigure = true;
      env.NIX_CFLAGS_COMPILE = "-I${pkgs.nodejs}/include/node";
      preBuild = ''
        substituteInPlace CMakeLists.txt \
            --replace-fail 'OPENSSL_USE_STATIC_LIBS TRUE' 'OPENSSL_USE_STATIC_LIBS FALSE' \
            --replace-fail 'if(NOT libdatachannel)' 'if(false)' \
            --replace-fail 'datachannel-static' 'datachannel'
        sed -i '2ifind_package(plog)' CMakeLists.txt
        substituteInPlace node_modules/cmake-js/lib/dist.js \
            --replace-fail '!this.downloaded' 'false'
      '';
      installPhase = ''
        runHook preInstall
        install -Dm755 build/Release/*.node -t $out/build/Release
        runHook postInstall
      '';
    };
  in {
    packages.webtorrent-cli = pkgs.buildNpmPackage rec {
      pname = "webtorrent-cli";
      version = "6.0.0";

      src = pkgs.fetchFromGitHub {
        owner = "webtorrent";
        repo = "webtorrent-cli";
        rev = "848cbfa310d35ca15324b88c01fc50ae24b572a2";
        hash = "sha256-/ToKj0xjJ4+FJ+XIhBWRAdwI2ZbMsBqIFYxmjTQkM4s=";
      };

      makeCacheWritable = true;

      npmDepsHash = "sha256-D3+7D8xW/SDEVc9irX/KdQ6N73pJwDi9mDTO07Kio98=";
      npmFlags = ["--ignore-scripts"];

      postPatch = ''
        cp ${./package-lock.json} ./package-lock.json
      '';

      postConfigure = ''
        ln -s ${nodeDatachannel}/build node_modules/node-datachannel/build
      '';

      dontNpmBuild = true;
      dontNpmPrune = true;

      meta = with pkgs.lib; {
        description = "WebTorrent, the streaming torrent client. For the command line.";
        homepage = "https://github.com/webtorrent/webtorrent-cli";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "webtorrent";
      };
    };
  };
}
