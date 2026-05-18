{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.searx = {lib, ...}: {
    services.searx = {
      enable = true;
      redisCreateLocally = true;

      settings = {
        server = {
          port = 8080;
          bind_address = "0.0.0.0";
          secret_key = "";
          limiter = false;
          public_instance = true;
        };

        search = {
          safe_search = 0;
          autocomplete_min = 2;
          autocomplete = "duckduckgo";
          ban_time_on_fail = 5;
          max_ban_time_on_fail = 120;
        };

        engines = lib.mapAttrsToList (name: value: {inherit name;} // value) {
          "duckduckgo".disabled = false;
          "wiby".disabled = false;
          "brave".disabled = false;
          "ddg definitions".disabled = false;
          "ddg definitions".weight = 2;

          "google images".disabled = false;
          "duckduckgo images".disabled = false;
          "qwant images".disabled = false;
          "deviantart".disabled = false;
          "artstation".disabled = false;
          "pinterest".disabled = false;
          "artic".disabled = false;
          "imgur".disabled = false;
          "library of congress".disabled = false;

          "brave.images".disabled = true;
          "1x".disabled = true;
          "flickr".disabled = true;
          "material icons".disabled = true;
          "material icons".weight = 0.2;
          "openverse".disabled = false;

          "svgrepo".disabled = true;
          "unsplash".disabled = false;
          "wallhaven".disabled = false;
          "wikicommons.images".disabled = false;
          "yacy images".disabled = true;

          "bing".disabled = true;
          "bing images".disabled = true;
          "bing videos".disabled = true;

          "mojeek".disabled = true;
          "mwmbl".disabled = true;
          "mwmbl".weight = 0.4;
          "qwant".disabled = true;
          "crowdview".disabled = false;
          "crowdview".weight = 0.5;
          "curlie".disabled = true;

          "wikibooks".disabled = false;
          "wikidata".disabled = false;
          "wikiquote".disabled = true;
          "wikisource".disabled = true;
          "wikispecies".disabled = false;
          "wikispecies".weight = 0.5;
          "wikiversity".disabled = false;
          "wikiversity".weight = 0.5;
          "wikivoyage".disabled = false;
          "wikivoyage".weight = 0.5;

          "currency".disabled = true;
          "dictzone".disabled = true;
          "lingva".disabled = true;

          "youtube".disabled = false;
          "qwant videos".disabled = false;
          "peertube".disabled = false;
          "sepiasearch".disabled = false;
          "invidious".disabled = false;
          "odysee".disabled = false;

          "brave.videos".disabled = true;
          "duckduckgo videos".disabled = true;
          "google videos".disabled = true;
          "dailymotion".disabled = true;
          "google play movies".disabled = true;
          "piped".disabled = true;
          "rumble".disabled = true;
          "vimeo".disabled = true;
          "brave.news".disabled = true;
          "google news".disabled = true;
        };

        enabled_plugins = [
          "Basic Calculator"
          "Hash plugin"
          "Tor check plugin"
          "Open Access DOI rewrite"
          "Hostnames plugin"
          "Unit converter plugin"
          "Tracker URL remover"
        ];
      };
    };
  };
}
