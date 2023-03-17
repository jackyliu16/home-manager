{ pkgs, ... }:
# Status Bar Configuration 

{
  programs.nixvim.plugins.lightline = {
    enable = true;
    colorscheme = "wombat";
  };
}
