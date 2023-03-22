{ pkgs, config, ... }: {

  programs.nixvim = {

    maps.normal = {
      "<C-e>" = ":NvimTreeToggle<CR>";
    };
    plugins = {
      # neo-tree.enable = true;
      treesitter = {
        enable = true;
        indent = true;
        ensureInstalled = [ "rust" "python" "c" "cpp" "toml" "nix" "go" "java" ];
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          c
          go
          cpp
          nix
          bash
          html
          help
          latex
          python
          rust
        ];
      };
    };
  };
}
