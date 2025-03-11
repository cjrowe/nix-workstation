{ nixvim, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    nodejs
    jdk
    terraform
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      palette = "catppuccin_mocha";
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g status-bg "#1e1e2e"  # base
      set -g status-fg "#cdd6f4"  # text
      set -g pane-border-style fg="#585b70"  # surface2
      set -g pane-active-border-style fg="#89b4fa"  # blue
    '';
  };

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    plugins = {
      lsp.enable = true;
      lsp.servers = {
        terraformls.enable = true;
        pyright.enable = true;
        tsserver.enable = true;
        jdtls.enable = true;
      };
    };
  };
}
