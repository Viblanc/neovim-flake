{ pkgs, config, lib, ... }:
with lib;
with builtins;
let
  cfg = config.vim;
in {
  options.vim = {
    highlights = mkOption {
      description = "Highlights to customize neovim's colors";
      type = types.attrs;
      default = import ../themes/gravity.nix;
    };
  };

  config =
  let
    optionsToString = options:
      concatStringsSep ","
      (mapAttrsToList (k: v: "${k}=${toJSON v}") options);
    highlights = concatStringsSep "\n" 
      (mapAttrsToList (hiGroup: options:
        "vim.api.nvim_set_hl(0, '${hiGroup}', { ${optionsToString options} })") config.vim.highlights);
  in {
    vim.luaConfigRC = ''
      ${highlights}
    '';
  };
}
