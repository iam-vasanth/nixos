{ ... }:

{
  home.file."Pictures/Wallpapers".source = ../../../../Wallpapers;
  home.file.".config/fastfetch/ascii.txt".source = ./ascii.txt;
  home.file.".ssh/github_ssh.pub".source = ../../../../.secrets/public_keys/github_ssh.pub;
}
