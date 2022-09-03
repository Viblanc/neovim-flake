{ pkgs, lib, config, ... }:
with lib;

let
  cfg = config.vim.cmp;
in {
  options.vim.cmp = {
    enable = mkOption {
      description = "Enable completion with nvim-cmp";
      default = true;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp-buffer
      cmp-cmdline
      cmp-under-comparator
      cmp_luasnip
      luasnip
    ];

    vim.luaConfigRC = ''
      local icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "⌘",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Unit = "塞",
        Property = "ﰠ",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
      }

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local under_compare = require("cmp-under-comparator")

      function has_words_before()
        local col = vim.fn.col(".") - 1
        local ln = vim.fn.getline(".")
        return (col == 0) or (string.match (string.sub(ln, col, col), "%s"))
      end

      function replace_termcodes(code)
        vim.api.nvim_replace_termcodes(code, true, true, true)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) 
          end
        },
        mapping = {
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), {"i", "s"}),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), {"i", "s"}),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s", "c" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s", "c" }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.confirm({ select = true })
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer", keyword_length = 5 }
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            under_compare.under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order
          },
        },
        experimental = {
          native_menu = false,
          ghost_text = true
        },
        window = {
          documentation = {
            border = "solid"
          },
          completion = {
            border = "solid"
          }
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(_, vim_item)
            vim_item.menu = vim_item.kind
            vim_item.kind = icons[vim_item.kind]
            return vim_item
          end
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        formatting = {
          fields = { "abbr" }
        },
        view = {
          separator = "|"
        },
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" }
        })
      })
    '';
  };
}
