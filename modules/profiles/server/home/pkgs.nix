{pkgs, ...}: {
  ###########################################################################
  # User specific packages
  ###########################################################################

  home.packages = [
    pkgs._7zz-rar
    pkgs.btop
    # ... add more packages here

    # sops-nix
    pkgs.sops
    pkgs.age
    pkgs.ssh-to-age
  ];
}
