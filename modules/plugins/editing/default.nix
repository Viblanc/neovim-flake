{ pkgs, lib, config, ... }:
let
  neovimPlugins = with pkgs.neovimPlugins; [
    comment-nvim
    vim-easy-align
    vim-surround
    vim-repeat
  ];
  vimExtraPlugins = with pkgs.vimExtraPlugins; [
    leap-nvim
  ];
in {
  config = {
    vim.startPlugins = neovimPlugins ++ vimExtraPlugins;

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

      require("leap").set_default_keymaps()
    '';
  };
}
