{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with builtins; 
let
  cfg = config.vim;

  wrapLuaConfig = luaConfig: ''
    lua << EOF
    ${luaConfig}
    EOF
  '';

  keymaps2Lua = keymaps:
    let fun = keymap:
      let
        inherit (keymap) mode;
        prefix = if (hasAttr "prefix" keymap) then keymap.prefix else "";
        opts = if (hasAttr "options" keymap) then
          "{" + concatStringsSep "," (map (o: "${o} = true") keymap.options) + "}"
        else
          "{}";
        mappings = removeAttrs keymap [ "prefix" "mode" "options" ];
      in
        concatStrings 
        (mapAttrsToList 
          (lhs: rhs: "vim.keymap.set(${toJSON mode}, ${toJSON (prefix + lhs)}, ${toJSON rhs}, ${opts})") mappings);
    in concatStringsSep "\n" (map fun keymaps);

  keymaps2LuaWithMode = keymaps: mode:
    keymaps2Lua {
      inherit mode;
    } // keymaps;

  mkKeymapOption = it:
    mkOption ({
      default = [];
      type = with types; listOf attrs;
    } // it);
in {
  imports = [
    ./options.nix
    ./highlights.nix
    ../ui/statusline.nix
    ../plugins
  ];

  options.vim = {
    viAlias = mkOption {
      description = "Enable vi alias";
      type = types.bool;
      default = true;
    };

    vimAlias = mkOption {
      description = "Enable vim alias";
      type = types.bool;
      default = true;
    };

    configRC = mkOption {
      description = "vimrc contents";
      type = types.lines;
      default = "";
    };

    startLuaConfigRC = mkOption {
      description = "start of vim lua config";
      type = types.lines;
      default = "";
    };

    luaConfigRC = mkOption {
      description = "vim lua config";
      type = types.lines;
      default = "";
    };

    startPlugins = mkOption {
      description = "List of plugins to startup";
      default = [];
      type = with types; listOf (nullOr package);
    };

    optPlugins = mkOption {
      description = "List of plugins to optionally load";
      default = [];
      type = with types; listOf package;
    };

    globals = mkOption {
      default = {};
      description = "Set containing global variable values";
      type = types.attrs;
    };

    keymaps = mkKeymapOption {
      description = "List of keymaps";
    };

    nmap = mkKeymapOption {
      description = "List of keymaps in normal mode";
    };

    xmap = mkKeymapOption {
      description = "List of keymaps in visual mode";
    };

    imap = mkKeymapOption {
      description = "List of keymaps in insert mode";
    };
  };

  config = let
    filterNonNull = mappings: filterAttrs (name: value: value != null) mappings;
    globalsScript =
      mapAttrsFlatten (name: value: "let g:${name}=${toJSON value}")
      (filterNonNull cfg.globals);
  in {
    vim.configRC = ''
      ${concatStringsSep "\n" globalsScript}
      " Lua config from vim.luaConfigRC
      ${wrapLuaConfig
        (concatStringsSep "\n" [cfg.startLuaConfigRC 
                                cfg.luaConfigRC 
                                (keymaps2Lua cfg.keymaps)
                                (keymaps2LuaWithMode cfg.nmap "n")
                                (keymaps2LuaWithMode cfg.xmap "x")
                                (keymaps2LuaWithMode cfg.imap "i")])}
    '';
  };
}
