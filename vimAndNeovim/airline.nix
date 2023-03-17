{ pkgs, ... }:

{
  programs.nixvim.plugins.airline = {
    enable = true;
    theme = "Plug";
  };
}
