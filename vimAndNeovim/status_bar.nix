{ pkgs, ... }:
# Status Bar Configuration 

{
  # only one could be enable at the time
  programs.nixvim.plugins = {
    lightline = {
      enable = true;
      colorscheme = "wombat";
    };
    lualine = {
      enable = false;
    };
    airline = {
      enable = false;
      theme = "Plug";
    };
  };
}
