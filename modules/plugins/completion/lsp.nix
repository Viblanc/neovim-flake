{ pkgs, lib, config, ... }:
with lib;
with builtins;

let
  cfg = config.vim.lsp;
  installIf = option: pkg: if cfg.${option} then pkg else null;
in {
  options.vim.lsp = {
    enable = mkEnableOption "Enable LSP in Neovim";
    clang = mkEnableOption "Enable C/C++ with clang";
    elixir = mkEnableOption "Enable Elixir support";
    go = mkEnableOption "Enable Go support";
    java = mkEnableOption "Enable Java support";
    lua = mkEnableOption "Enable Lua support";
    ocaml = mkEnableOption "Enable OCaml support";
    python = mkEnableOption "Enable Python support";
    rust = mkEnableOption "Enable Rust support";
    typescript = mkEnableOption "Enable TypeScript/JavaScript support";
    servers = mkOption {
      description = "List of language servers";
      default = [];
      type = with types; listOf (nullOr package);
    };

  };

  config = mkIf cfg.enable {
    vim.lsp.servers = with pkgs; [
      clang-tools
      elixir_ls
      gopls
      jdt-language-server
      sumneko-lua-language-server
      ocamlPackages.ocaml-lsp
      nodePackages.pyright
      rust-analyzer
      nodePackages.typescript-language-server
    ];

    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-lspconfig
    ];

    vim.luaConfigRC = ''
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      local servers = {
        "clangd",
        "elixirls",
        "gopls",
        "jdtls",
        "sumneko_lua",
        "ocamllsp",
        "pyright",
        "rust_analyzer",
        "tsserver"
      }
      for _, server in ipairs(servers) do
        lspconfig[server].setup {
          capabilities = capabilities
        }
      end
    '';
  };
}

