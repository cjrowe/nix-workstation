{ nixvim, private-config, config, pkgs, ... }:

{
  imports = [
    ./shared.nix
    private-config.homeManagerModules.private
  ];

  programs.git = {
    enable = true;
    userName = "Chris (Home Desktop)";
    # Email provided by private-config
  };
}
