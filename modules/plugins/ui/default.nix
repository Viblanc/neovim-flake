{ pkgs, lib, config, ... }:
{
  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-notify
      fidget-nvim
      lsp_lines-nvim
      nvim-web-devicons
    ];

    vim.luaConfigRC = ''
      vim.notify = require("notify")

      require("fidget").setup()

      require("lsp_lines").setup()
      '';
  };
}
