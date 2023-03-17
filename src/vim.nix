{ pkgs, lib, ... }:

let 
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/pta2022/nixvim";
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
