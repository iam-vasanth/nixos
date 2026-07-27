{
  lib,
  inputs,
  user,
  pkgs,
  config,
  paths,
  ...
}: {
  imports = [
    # Aliases
    (lib.mkAliasOptionModule ["hj"] ["hjem" "users" "${user}"])
    (lib.mkAliasOptionModule ["hjf"] ["hjem" "users" "${user}" "files"])
  ];

  ###########################################################################
  # Hjem configuration
  ###########################################################################

  hjem = {
    linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
    clobberByDefault = true;
    extraModules = [
      # inputs.qtengine.hjemModules.default
      # inputs.hjem-impure.hjemModules.default
      # inputs.hjem-rum.hjemModules.default
    ];
  };
  hj = {
    clobberFiles = true;
    user = user;
    directory = config.users.users.${user}.home;
    files = {
      "Pictures/.face.png".source = paths.dots + /profile.png;
    };
  };
}
