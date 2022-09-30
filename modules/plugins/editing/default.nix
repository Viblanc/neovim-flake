{ pkgs, lib, config, ... }:
let
  neovimPlugins = with pkgs.neovimPlugins; [
    comment-nvim
    vim-easy-align
    vim-surround
    vim-repeat
  ];
in {
  config = {
    vim.startPlugins = neovimPlugins;

    vim.keymaps = [
      {
        mode = "n";
        "ga" = "<Plug>(EasyAlign)";
      }
      {
        mode = "x";
        "ga" = "<Plug>(EasyAlign)";
      }
    ];

    vim.luaConfigRC = ''
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "gcc",
          block = "gbc"
        },
        opleader = {
          line = "gc",
          block = "gb"
        },
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA"
        }
      })
    '';
  };
}
