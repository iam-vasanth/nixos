{
  pkgs,
  unstable,
  ...
}:
pkgs.mkShell {
  name = "java";

  packages = [
    ###########################################################################
    # JDK
    ###########################################################################
    pkgs.jdk21

    ###########################################################################
    # Build tools
    ###########################################################################
    pkgs.maven
    pkgs.gradle

    ###########################################################################
    # Extras
    ###########################################################################
    pkgs.jdt-language-server
    pkgs.google-java-format
    pkgs.visualvm
  ];

  JAVA_HOME = "${pkgs.jdk21}";

  shellHook = ''
    echo "== java devshell =="
    java -version
    echo "maven  $(mvn --version | head -n1)"
    echo "gradle $(gradle --version | ${pkgs.gnugrep}/bin/grep Gradle)"
  '';
}
