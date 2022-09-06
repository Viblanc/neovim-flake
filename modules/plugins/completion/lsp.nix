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
        "e"    = "<Cmd>lua vim.diagnostic.open_float()<CR>";
        "rn"   = "<Cmd>lua vim.lsp.buf.rename()<CR>";
        "ca"   = "<Cmd>lua vim.lsp.buf.code_action()<CR>";
        "f"    = "<Cmd>lua vim.lsp.buf.formatting()<CR>";
        "k"    = "<Cmd>lua vim.lsp.buf.hover()<CR>";
      }
      {
        "(d"    = "<Cmd>lua vim.diagnostic.goto_prev()<CR>";
        ")d"    = "<Cmd>lua vim.diagnostic.goto_next()<CR>";
        "gd"    = "<Cmd>lua vim.lsp.buf.definition()<CR>";
        "gD"    = "<Cmd>lua vim.lsp.buf.declaration()<CR>";
        "gi"    = "<Cmd>lua vim.lsp.buf.implementation()<CR>";
        "<C-k>" = "<Cmd>lua vim.lsp.buf.signature_help()<CR>";
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

