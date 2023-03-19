{ pkgs, ... }:
# Status Bar Configuration 

{
  # only one could be enable at the time
  programs.nixvim.plugins = {
    lightline = {
      enable = false;
      colorscheme = "wombat";
    };
    lualine = {
      enable = true;
    };
    airline = {
      enable = false;
      theme = "Plug";
    };
  };
}
