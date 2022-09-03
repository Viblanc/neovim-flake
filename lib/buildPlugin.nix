{ pkgs, inputs, plugins, ... }:
final: prev:
let
  inherit (prev.vimUtils) buildVimPluginFrom2Nix;

  languageServers = prev.withPlugins (p: [
    p.clang-tools
    p.elixir_ls
    p.gopls
    p.jdt-language-server
    p.sumneko-lua-language-server
    p.ocamlPackages.ocaml-lsp
    p.nodePackages.pyright
    p.rust-analyzer
    p.nodePackages.typescript-language-server
  ]);

  treesitterGrammars = prev.tree-sitter.withPlugins (p: [
    p.tree-sitter-c
    p.tree-sitter-css
    p.tree-sitter-elixir
    p.tree-sitter-fennel
    p.tree-sitter-go
    p.tree-sitter-java
    p.tree-sitter-javascript
    p.tree-sitter-json
    p.tree-sitter-lua
    p.tree-sitter-markdown
    p.tree-sitter-nix
    p.tree-sitter-ocaml
    p.tree-sitter-python
    p.tree-sitter-query
    p.tree-sitter-rust
    p.tree-sitter-toml
    p.tree-sitter-tsx
    p.tree-sitter-typescript
  ]);

  buildPlug = name:
    buildVimPluginFrom2Nix {
      pname = name;
      version = "master";
      src = builtins.getAttr name inputs;
      postPatch =
        if (name == "nvim-treesitter") then ''
          rm -r parser
          ln -s ${treesitterGrammars} parser
        ''
        else if (name == "telescope-fzf-native-nvim") then ''
          make
        ''
        else "";
    };
in {
  neovimPlugins =
    builtins.listToAttrs (map (name: {
      inherit name;
      value = buildPlug name;
    }) plugins);
}
