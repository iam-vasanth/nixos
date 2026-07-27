{...}: {
  ###########################################################################
  # SSH config
  ###########################################################################

  hjf.".ssh/config" = {
    text = ''
      Host github.com
        IdentityFile ~/.ssh/git_zoro
        AddKeysToAgent yes

      Host gitlab.com
        IdentityFile ~/.ssh/git_zoro
        AddKeysToAgent yes
    '';
    type = "copy";
    permissions = "600";
  };
}
