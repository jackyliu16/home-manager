{ pkgs, config, ... }: {

  programs.nixvim = {

    maps.normal = {
      "<C-e>" = ":NvimTreeToggle<CR>";
    };
    plugins = {
      # neo-tree.enable = true;
      nvim-tree = {
        enable = true;
        autoClose = true;
        filters = {
          dotfiles = false;
          exclude = [                 # include in nvim-tree
            ".gitignore"
          ];
          custom = [                  # exclude in nvim-tree
            "^\\.git"
          ];
        };    
        actions.useSystemClipboard = true;
      };
    };
  };
}
