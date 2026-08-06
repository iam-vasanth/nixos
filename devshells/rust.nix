{
  pkgs,
  unstable,
  ...
}:
pkgs.mkShell {
  name = "rust";

  packages = [
    ###########################################################################
    # Toolchain
    ###########################################################################
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.clippy
    pkgs.rust-analyzer

    ###########################################################################
    # Cargo extensions
    ###########################################################################
    pkgs.cargo-watch
    pkgs.cargo-edit
    pkgs.cargo-audit
    pkgs.cargo-outdated
    pkgs.cargo-nextest
    pkgs.cargo-expand

    ###########################################################################
    # Build essentials
    ###########################################################################
    pkgs.pkg-config
    pkgs.openssl
    pkgs.gcc
  ];

  RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

  shellHook = ''
    echo "== rust devshell =="
    echo "$(rustc --version)"
    echo "$(cargo --version)"
  '';
}
