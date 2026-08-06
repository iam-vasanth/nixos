{
  pkgs,
  unstable,
  ...
}:
pkgs.mkShell {
  name = "devops";

  packages = [
    ###########################################################################
    # IaC
    ###########################################################################
    pkgs.terraform
    pkgs.opentofu
    pkgs.terragrunt
    pkgs.terraform-docs
    pkgs.tflint

    ###########################################################################
    # Cloud
    ###########################################################################
    pkgs.awscli2
    pkgs.ssm-session-manager-plugin

    ###########################################################################
    # Kubernetes
    ###########################################################################
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.helmfile
    pkgs.k9s
    pkgs.kubectx
    pkgs.kustomize
    pkgs.stern

    ###########################################################################
    # Containers
    ###########################################################################
    pkgs.docker-client
    pkgs.docker-compose
    pkgs.dive
    pkgs.lazydocker

    ###########################################################################
    # Config management / secrets
    ###########################################################################
    pkgs.ansible
    pkgs.sops
    pkgs.age
    pkgs.age-plugin-yubikey

    ###########################################################################
    # General purpose
    ###########################################################################
    pkgs.jq
    pkgs.yq-go
    pkgs.shellcheck
    pkgs.direnv
  ];

  shellHook = ''
    echo "== devops devshell =="
    echo "terraform  $(terraform version -json 2>/dev/null | ${pkgs.jq}/bin/jq -r .terraform_version 2>/dev/null || terraform version | head -n1)"
    echo "kubectl    $(kubectl version --client=true --output=yaml 2>/dev/null | ${pkgs.yq-go}/bin/yq -r .clientVersion.gitVersion 2>/dev/null)"
    echo "aws        $(aws --version 2>&1)"
  '';
}
