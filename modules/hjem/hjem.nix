{
  lib,
  inputs,
  user,
  pkgs,
  config,
  paths,
  impure,
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
    clobberByDefault = true;
    extraModules = [
      # inputs.qtengine.hjemModules.default
      inputs.hjem-impure.hjemModules.default
      # inputs.hjem-rum.hjemModules.default
    ];
  };
  hj = {
    clobberFiles = true;
    user = user;
    directory = config.users.users.${user}.home;

    impure = {
      enable = true;
      dotsDir = impure.dots;
      dotsDirImpure = impure.dotsImpure;
    };

    files = {
      "Pictures/.face.png".source = paths.dots + /profile.png;
    };
  };
}
