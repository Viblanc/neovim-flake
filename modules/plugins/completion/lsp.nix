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
    nix = mkEnableOption "Enable Nix support";
    ocaml = mkEnableOption "Enable OCaml support";
    python = mkEnableOption "Enable Python support";
    rust = mkEnableOption "Enable Rust support";
    typescript = mkEnableOption "Enable TypeScript/JavaScript support";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-lspconfig
    ];

    vim.nmap = [
      {
        prefix = "<Leader>";
        "e"    = "lua vim.diagnostic.open_float()";
        "rn"   = "lua vim.lsp.buf.rename()";
        "ca"   = "lua vim.lsp.buf.code_action()";
        "f"    = "lua vim.lsp.buf.formatting()";
        "k"    = "lua vim.lsp.buf.hover()";
      }
      {
        "(d"    = "lua vim.diagnostic.goto_prev()";
        ")d"    = "lua vim.diagnostic.goto_next()";
        "gd"    = "lua vim.lsp.buf.definition()";
        "gD"    = "lua vim.lsp.buf.declaration()";
        "gi"    = "lua vim.lsp.buf.implementation()";
        "<C-k>" = "lua vim.lsp.buf.signature_help()";
      }
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
        "rnix",
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

