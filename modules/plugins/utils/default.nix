{ pkgs, lib, config, ... }:
let
  neovimPlugins = with pkgs.neovimPlugins; [
    trouble-nvim
    nvim-tree-lua
    nvim-colorizer-lua
    vim-startuptime
    fugitive
  ];
in {
  config = {
    vim.startPlugins = neovimPlugins;

    vim.nmap = [
      {
        "<C-n>" = "NvimTreeToggle";
      }
    ];

    vim.luaConfigRC = ''
      require("trouble").setup({
        auto_open = false,
        use_diagnostics_sign = true
      })

      require("nvim-tree").setup()

      require("colorizer").setup({
        "*";
      }, {
        mode = "foreground"
      })
    '';
  };
}
