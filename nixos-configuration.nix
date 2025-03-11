{ config, pkgs, ... }:

{
  users.users.chris = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    st
  ];

  programs.steam.enable = true;
}
