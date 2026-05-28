{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.discord = {
    pkgs,
    config,
    ...
  }: {
    imports = [inputs.nixcord.nixosModules.nixcord];
    programs.nixcord = {
      enable = true;
      user = "${config.preferences.user.name}";

      discord.vencord.enable = false;
      discord.equicord.enable = true;

      #legcord.enable = true;
      #legcord.equicord.enable = true;

      config = {
        autoUpdate = true;

        frameless = true;

        enabledThemes = ["noctalia.theme.css"];

        plugins = {
          # QOL
          betterActivities.enable = true;
          platformIndicators.enable = true;
          volumeBooster.enable = true;
          voiceChatDoubleClick.enable = true;
          betterUploadButton.enable = true;
          biggerStreamPreview.enable = true;
          favoriteGifSearch.enable = true;
          SaveFavoriteGIFs.enable = true;
          gifCollections.enable = true;
          userVoiceShow.enable = true;
          mentionAvatars.enable = true;
          typingIndicator.enable = true;
          typingTweaks.enable = true;
          silentTyping.enable = true;
          showConnections.enable = true;
          replyTimestamp.enable = true;
          pictureInPicture.enable = true;
          newGuildSettings.enable = true;
          whoReacted.enable = true;
          MutualGroupDMs.enable = true;
          messageLogger = {
            enable = true;
            collapseDeleted = true;
            ignoreSelf = true;
            ignoreBots = true;
          };
          gifPaste.enable = true;
          fullSearchContext.enable = true;
          friendsSince.enable = true;
          fixCodeblockGap.enable = true;
          fixImagesQuality.enable = true;
          fixYoutubeEmbeds.enable = true;
          fixFileExtensions.enable = true;
          clickableRoles.enable = true;

          # must
          youtubeAdblock.enable = true;
          ClearURLs.enable = true;
          webKeybinds.enable = true;
          webScreenShareFixes.enable = true;
          crashHandler.enable = true;
          translate.enable = true;
          showHiddenThings.enable = true;
          readAllNotificationsButton.enable = true;
          noUnblockToJump.enable = true;
          noBlockedMessages.enable = true;
          noF1.enable = true;
        };
      };
    };
  };
}
