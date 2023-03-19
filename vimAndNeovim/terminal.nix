{ pkgs, lib, config }:

programs.nixvim = {
  maps = {
    normal = {
      # Terminal(floaterm)
      "<A-1>" = ":FloatermNew --with-type=split --height=0.4<CR>";
      "<A-2>" = ":FloatermNew --with-type=vsplit --width=0.4<CR>";
      "<A-3>" = ":FloatermNew<CR>";
      "<C-j>" = ":FloatermShow<CR>";
    };
    terminal = {
      # floaterm
      "<C-j>" = "<C-\\><C-n>:FloatermHide<CR>";
      "<C-w>" = "<C-\\><C-n>:FloatermKill<CR>";
    };
  };

  floaterm = {
    enable = true;
    width = 0.8;
    height = 0.8;
  };
}