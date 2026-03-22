{ config, inputs, ... }:

let
  secretspath = builtins.toString inputs.sops-secrets;
in

{
  programs.git = {
    enable = true;
    signing = {
      key = "${config.home.homeDirectory}/.ssh/zoro_key.pub";
      signByDefault = true;
      format = "ssh";
    };
    ignores = [
      "*.swp"
      "*~"
      ".DS_Store"
      ".direnv/"
      "result"
      "result-*"
    ];
    settings = {
      user.name = "iam-vasanth";
      user.email = "vk.vasanth.r@gmail.com";

      url = {
        "git@github.com:" = { insteadOf = "https://github.com/"; };
        "git@gitlab.com:" = { insteadOf = "https://gitlab.com/"; };
      };

      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "zed --wait";
        pull.rebase = true;
        push.autoSetupRemote = true;
        "gpg.ssh".allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
        tag.gpgSign = true;
      };
    };
  };

  # modules/home-common/git.nix
  home.file.".config/git/allowed_signers".text =
    let
      pubKey = builtins.readFile "${secretspath}/public_keys/zoro_key.pub";
    in ''
      @gmail.com namespaces="git" ${pubKey}
    '';
}
