{ pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/pta2002/nixvim";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    # For NixOS nixvim.nixosModules.nixvim
    # For nix-darwin nixvim.nixDarwinModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    options = {
      mouse = "a";
      spelllang = "en_us";
      clipboard = "unnamedplus";

      wrap = true;
      smartindent = true;

      number = true;
      relativenumber = true;
      expandtab = true;
      copyindent = true;

      shiftwidth = 2;
      tabstop = 2;

      background = "dark";
    };
  };
}