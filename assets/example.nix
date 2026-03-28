
# Order of module args
{ config, lib, inputs, user, hostname, pkgs, unstable, ... }:

{

  ###########################################################################
  # Main heading (What is the code block for)
  ###########################################################################

  # Can add comments inside the block for more information.
  services.docker.enable = true;

  ###########################################################################
  # Order of modules
  ###########################################################################
  # Imports
  # Bootloader, kernal params and other boot stuffs
  # Nix specific settings (Flakes, unfree package, ...)
  # Hostname
  # Users
  # Timezone
  # Networking
  # DE, display manager, sound and power profiles
  # Programs
  # Services
  # Packages and font pkgs
  # Nix GC and Optimise
  # State version

}
