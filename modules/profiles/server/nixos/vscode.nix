{ config, pkgs, ... }:

{
  services.code-server = {
    enable = true;
    host = "0.0.0.0";
    port = 6767;
    auth = "none";
    # auth = "password";
    user = "zoro";
    extraArguments = [ "--disable-telemetry" ];
  };

  # Open the port in the firewall
  networking.firewall.allowedTCPPorts = [ 6767 ];

  # Optional: Good Nix tools + editor
  environment.systemPackages = with pkgs; [
    nixd
    alejandra
  ];
}
