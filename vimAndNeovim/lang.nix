{ pkgs, ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      bashls.enable = true;   # for bash
      cssls.enable = true;    # for css
      clangd.enable = true;   # for c and cpp
      gopls.enable = true;    # for go
      hls.enable = true;      # for haskell
      html.enable = true;     # for html
      jsonls.enable = true;   # for json
      lua-ls.enable = true;   # for lua
      nil_ls.enable = true;   # for nix
      # rnix-lsp.enable = true; # for nix
      # pylsp.enable = true;    # for python
      pyright.enable = true;  # for python
      rust-analyzer.enable = true;  # for rust
      texlab.enable = true;   # for latex
    };
  };
}
