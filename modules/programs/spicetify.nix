{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  # hjem.extraModules = [ inputs.spicetify-nix.hjemModules.default ];
  # hj = {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      powerBar
      fullAlbumDate
      fullAppDisplay
      listPlaylistsWithSong
      volumePercentage
      adblock
      hidePodcasts
      beautifulLyrics
      autoSkipExplicit
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      newReleases
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
  # };
}
