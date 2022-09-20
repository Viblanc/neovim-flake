{
  description = "svzer's super sweet neovim config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";

    vim-extra-plugins.url = "github:m15a/nixpkgs-vim-extra-plugins";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rnix-lsp.url = "github:nix-community/rnix-lsp";

    nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    cmp-nvim-lua = { url = "github:hrsh7th/cmp-nvim-lua"; flake = false; };
    cmp-path = { url = "github:hrsh7th/cmp-path"; flake = false; };
    cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    cmp-cmdline = { url = "github:hrsh7th/cmp-cmdline"; flake = false; };
    cmp-nvim-tags = { url = "github:quangnguyen30192/cmp-nvim-tags"; flake = false; };
    cmp-under-comparator = { url = "github:lukas-reineke/cmp-under-comparator"; flake = false; };
    cmp_luasnip = { url = "github:saadparwaiz1/cmp_luasnip"; flake = false; };
    luasnip = { url = "github:l3mon4d3/luasnip"; flake = false; };
    nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    nvim-treesitter-context = { url = "github:nvim-treesitter/nvim-treesitter-context"; flake = false; };
    telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    telescope-fzf-native-nvim = { url = "github:nvim-telescope/telescope-fzf-native.nvim"; flake = false; };
    telescope-file-browser-nvim = { url = "github:nvim-telescope/telescope-file-browser.nvim"; flake = false; };
    comment-nvim = { url = "github:numtostr/comment.nvim"; flake = false; };
    vim-easy-align = { url = "github:junegunn/vim-easy-align"; flake = false; };
    vim-surround = { url = "github:tpope/vim-surround"; flake = false; };
    vim-repeat = { url = "github:tpope/vim-repeat"; flake = false; };
    leap-nvim = { url = "github:ggandor/leap.nvim"; flake = false; };
    trouble-nvim = { url = "github:folke/trouble.nvim"; flake = false; };
    nvim-tree-lua = { url = "github:kyazdani42/nvim-tree.lua"; flake = false; };
    nvim-colorizer-lua = { url = "github:norcalli/nvim-colorizer.lua"; flake = false; };
    vim-startuptime = { url = "github:dstein64/vim-startuptime"; flake = false; };
    fugitive = { url = "github:tpope/vim-fugitive"; flake = false; };
    matchparen-nvim = { url = "github:monkoose/matchparen.nvim"; flake = false; };
    nvim-notify = { url = "github:rcarriga/nvim-notify"; flake = false; };
    fidget-nvim = { url = "github:j-hui/fidget.nvim"; flake = false; };
    lsp_lines-nvim = { url = "sourcehut:~whynothugo/lsp_lines.nvim"; flake = false; };
    nvim-web-devicons = { url = "github:kyazdani42/nvim-web-devicons"; flake = false; };
  };

  outputs = { self, nixpkgs, utils, vim-extra-plugins, neovim, rnix-lsp, ... }@inputs:
  utils.lib.eachDefaultSystem
  (system:
    let
      plugins = [
        "nvim-lspconfig"
        "nvim-cmp"
        "cmp-nvim-lsp"
        "cmp-nvim-lua"
        "cmp-path"
        "cmp-buffer"
        "cmp-cmdline"
        "cmp-nvim-tags"
        "cmp-under-comparator"
        "cmp_luasnip"
        "luasnip"
        "nvim-treesitter"
        "nvim-treesitter-context"
        "telescope-nvim"
        "plenary-nvim"
        "telescope-fzf-native-nvim"
        "telescope-file-browser-nvim"
        "comment-nvim"
        "vim-easy-align"
        "vim-surround"
        "vim-repeat"
        "leap-nvim"
        "trouble-nvim"
        "nvim-tree-lua"
        "nvim-colorizer-lua"
        "vim-startuptime"
        "fugitive"
        "matchparen-nvim"
        "nvim-notify"
        "fidget-nvim"
        "lsp_lines-nvim"
        "nvim-web-devicons"
      ];

      vimExtraPluginsOverlay = vim-extra-plugins.overlays.default;

      neovimOverlay = final: prev: {
        neovim-nightly = neovim.packages.${prev.system}.neovim;
        rnix-lsp = rnix-lsp.packages.${prev.system}.rnix-lsp;
      };

      pluginsOverlay = lib.buildPluginOverlay;

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          vimExtraPluginsOverlay
          neovimOverlay
          pluginsOverlay
        ];
      };

      lib = import ./lib { inherit pkgs inputs plugins; };

      mkNeovimPkg = pkgs: 
        lib.neovimBuilder {
          inherit pkgs;
          config = {
            vim.viAlias = true;
            vim.treesitter.enable = true;
            vim.lsp.enable = true;
            vim.lsp.clang = true;
            vim.lsp.elixir = true;
            vim.lsp.go = true;
            vim.lsp.java = true;
            vim.lsp.lua = true;
            vim.lsp.nix = true;
            vim.lsp.ocaml = true;
            vim.lsp.python = true;
            vim.lsp.rust = true;
            vim.lsp.typescript = true;
          };
        };

    in rec {
      packages = rec {
        neovim-svzer = mkNeovimPkg pkgs;
        default = neovim-svzer;
      };
      apps = rec {
        neovim-svzer = utils.lib.mkApp { drv = packages.neovim-svzer; name = "nvim"; };
        default = neovim-svzer;
      };
    }
  );
}
