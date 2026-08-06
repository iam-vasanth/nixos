{
  pkgs,
  unstable,
  ...
}:
pkgs.mkShell {
  name = "python";

  packages = [
    ###########################################################################
    # Interpreter
    ###########################################################################
    pkgs.python3

    ###########################################################################
    # Package / project management
    ###########################################################################
    pkgs.uv
    pkgs.poetry

    ###########################################################################
    # Linting / formatting / typing
    ###########################################################################
    pkgs.ruff
    pkgs.black
    pkgs.mypy
    pkgs.pyright

    ###########################################################################
    # Build essentials (for native extensions)
    ###########################################################################
    pkgs.gcc
    pkgs.pkg-config
  ];

  shellHook = ''
    echo "== python devshell =="
    echo "$(python3 --version)"
    echo "uv     $(uv --version)"
    echo "poetry $(poetry --version)"
  '';
}
