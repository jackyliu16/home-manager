{ pkgs, ... }:
# terminal configuration

{
  programs.nixvim = {
    maps = {
      normal = {
        # Terminal(floaterm)
        "<A-1>" = ":FloatermNew --win-type=split --height=0.4<CR>";
        "<A-2>" = ":FloatermNew --win-type=vsplit --width=0.4<CR>";
        "<A-3>" = ":FloatermNew<CR>";
        "<C-j>" = ":FloatermShow<CR>";
      };
      terminal = {
        # Terminal(floaterm) 
        "<C-j>" = "<C-\\><C-n>:FloatermHide<CR>";
        "<C-w>" = "<C-\\><C-n>:FloatermKill<CR>";
      };
    };
    plugins.floaterm = {
      enable = true;
      width = 0.8;
      height = 0.8;
    };
  };
}