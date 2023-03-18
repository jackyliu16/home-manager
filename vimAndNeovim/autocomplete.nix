{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
      lspkind-nvim
      vim-vsnip
    ];

    plugins = {
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable   = true;
      cmp-path.enable     = true;
      cmp-cmdline.enable  = true;
      nvim-cmp = {
        enable = true;
        snippet.expand = "vsnip";
        sources = [
              # { name = "nvim_lsp"; }
              # { name = "vsnip"; }
              # { name = "luasnip"; } #For luasnip users.
              { name = "path"; }
              { name = "buffer"; }
        ];
        mapping = {
          # 选择上一个
          "<C-p>" = "cmp.select_prev_item()"; 
          # 选择下一个
          "<C-n>" = "cmp.select_next_item()";
          # 出现补全
          "<A-.>" = "cmp.mapping(cmp.mapping.complete(), {'i', 'c'})";
          # 取消补全
          "<A-,>" = "cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          })";
          # 确认使用某个补全项
          "<CR>" = "cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace  
          })";
          "<C-u>" = "cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'})"; # 向上翻页
          "<C-d>" = "cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'})";  # 向下翻页

        };
      };    

      cmp-vsnip.enable    = true;
    };
  };
}
