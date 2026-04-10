{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers."cloudflared" = {
      image = "cloudflare/cloudflared:latest";
      autoStart = true;
    };
  };
}
