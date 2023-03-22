{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
      # lspkind-nvim
      vim-vsnip
    ];

    plugins = {
      lspkind.enable = true;
      lsp = {
        keymaps.silent = true;
        keymaps.lspBuf = {
          "gd" = "definition";
          "gD" = "references";
          "ca" = "code_action";
          "gi" = "implementation";
          "gt" = "type_definition";
          "ff" = "format";
          "K"  = "hover";
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable   = true;
      cmp-path.enable     = true;
      cmp-cmdline.enable  = true;
      cmp-vsnip.enable    = true;
      nvim-cmp = {
        enable = true;
        snippet.expand = "vsnip";
        performance = {
          debounce = 60;
          throttle = 30;
          fetchingTimeout = 500;
        };
        mapping = {
          # prev page
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          # next page
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          # start complete
          "<C-Space>" = "cmp.mapping.complete()";
          # close complete
          "<C-e>" = "cmp.mapping.close()";
          # next item
          "<Tab>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_next_item()";
          };
          # prev item
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_prev_item()";
          };
          # confirm to using a specify complete item
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "vsnip"; }
          { name = "buffer"; }
          # { name = "neorg"; }
          # { name = "cmp_tabnine"; }
        ];
      };    
    };
    extraConfigLua = ''
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      cmp.setup({
          -- 设置代码片段引擎，用于根据代码片段补全
          window = {
          },

          --根据文件类型来选择补全来源
          cmp.setup.filetype('gitcommit', {
              sources = cmp.config.sources({
                  {name = 'buffer'}
              })
          }),

          -- 命令模式下输入 `/` 启用补全
          cmp.setup.cmdline('/', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                  { name = 'buffer' }
              }
          }),

          -- 命令模式下输入 `:` 启用补全
          cmp.setup.cmdline(':', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                  { name = 'path' }
              }, {
                      { name = 'cmdline' }
                  })
          }),

          -- 设置补全显示的格式
          formatting = {
              format = lspkind.cmp_format({
                  with_text = true,
                  maxwidth = 50,
                  before = function(entry, vim_item)
                      vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                      return vim_item
                  end
              }),
          },
      })
    '';
  };
}
