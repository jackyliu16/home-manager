{ pkgs, lib, ... }:

let 
  nixvim = import (builtins.fetchGit {
    url = "git@github.com:pta2002/nixvim.git";
  });
in
{
  imports = [
    # for home-manager 
    nixvim.homeManagerModules.nixvim
    # for NixOS
    # nixvim.nixosModules.nixvim
    # for nix-darwin
    # nixvim.nixDarwinModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
  };
}
