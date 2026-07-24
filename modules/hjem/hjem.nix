{
  inputs,
  self,
  user,
  lib,
  username,
  ...
}:
{
  modules.hjem._ =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        (lib.mkAliasOptionModule [ "hj" ] [ "hjem" "users" "${username}" ])
        (lib.mkAliasOptionModule [ "hjxdg" ] [ "hjem" "users" "${username}" "xdg" "config" "files" ])
      ];

      hjem = {
        linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
        clobberByDefault = true;
        extraModules = [
          # inputs.qtengine.hjemModules.default
          # inputs.hjem-impure.hjemModules.default
          inputs.hjem-rum.hjemModules.default
        ];
      };
      hjem.users.${username} = {
        clobberFiles = true;
        user = user;
        directory = config.users.users.${username}.home;
        files = {
          ".face.icon".source = self.paths.dots + "/profile.png";
        };
      };
    };
}
