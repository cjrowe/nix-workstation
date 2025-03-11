{ nixvim, private-config, config, pkgs, ... }:

{
  imports = [
    ./shared.nix
    private-config.homeManagerModules.private
  ];

  programs.git = {
    enable = true;
    userName = "Chris (SPW Laptop)";
    # Email provided by private-config
  };
}
