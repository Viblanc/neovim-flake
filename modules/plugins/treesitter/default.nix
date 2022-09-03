{ pkgs, lib, config, ... }:
with lib;
with builtins;

let
  cfg = config.vim.treesitter;
  nix2luaList = list:
  "{" + concatStringsSep "," list + "}";
in {
  options.vim.treesitter = {
    enable = mkEnableOption "Enable tree-sitter";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-treesitter
      nvim-treesitter-context
    ];

    vim.configRC = ''
      set foldlevelstart=20
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
    '';

    vim.luaConfigRC = ''
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true
        },
        indent = {
          enable = false
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner"
            }
          }
        }
      }
    '';
  };
}
