{ ... }:

{
  home.file."Pictures/Wallpapers".source = ../../../../assets/Wallpapers;
  home.file.".config/fastfetch/ascii.txt".source = ./ascii.txt;
  home.file.".ssh/zoro_key.pub".source = ../../../../.secrets/public_keys/zoro_key.pub;
}
