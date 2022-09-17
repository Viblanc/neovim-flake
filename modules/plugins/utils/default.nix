{ pkgs, lib, config, ... }:
let
  neovimPlugins = with pkgs.neovimPlugins; [
    trouble-nvim
    nvim-tree-lua
    nvim-colorizer-lua
    vim-startuptime
    vim-fugitive
  ];
  vimExtraPlugins = with pkgs.vimExtraPlugins; [
    matchparen-nvim
  ];
in {
  config = {
    vim.startPlugins = neovimPlugins ++ vimExtraPlugins;

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

      require("matchparen").setup({
        on_startup = true,
        hl_group = "MatchParen"
      })
    '';
  };
}
