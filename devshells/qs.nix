{
  pkgs,
  unstable,
  ...
}:
pkgs.mkShell {
  name = "quickshell";

  packages = [
    ###########################################################################
    # Quickshell itself
    ###########################################################################
    unstable.quickshell

    ###########################################################################
    # Qt / QML tooling
    ###########################################################################
    pkgs.qt6.qtdeclarative
    pkgs.qt6.qttools
    pkgs.qt6.qtsvg
    pkgs.qt6.qtimageformats
    pkgs.qt6.qt5compat

    ###########################################################################
    # QML LSP / formatting (for editor integration)
    ###########################################################################
    pkgs.qt6.qtdeclarative # provides qmlls

    ###########################################################################
    # Useful for testing widgets / IPC
    ###########################################################################
    pkgs.jq
    pkgs.socat
  ];

  QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";

  shellHook = ''
    echo "== quickshell devshell =="
    echo "$(quickshell --version 2>/dev/null || echo 'quickshell (unstable)')"
    echo "qml    $(qml --version 2>/dev/null || true)"
  '';
}
