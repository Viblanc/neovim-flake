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
    let fun = map:
      let
        inherit (map) mode;
        prefix = if (hasAttr "prefix" map) then map.prefix else "";
        opts = if (hasAttr "options" map) then
          "{" + concatStringsSep "," (map (o: "${o} = true") map.options) + "}"
        else
          "{}";
        mappings = removeAttrs map [ "prefix" "mode" "options" ];
      in
        concatStrings 
        (mapAttrsToList 
          (lhs: rhs: "vim.keymap.set(${mode}, ${prefix + lhs}, ${rhs}, ${opts})") mappings);
    in concatStringsSep "\n" (map fun keymaps);

  mkMappingOption = it:
    mkOption ({
        default = {};
        type = with types; attrsOf (nullOr str);
      }
      // it);
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

    keymaps = mkOption {
      default = [];
      description = "List of keymaps";
      type = with types; listOf (attrsOf (nullOr str));
    };

    omap = mkMappingOption {
      description = "Defines 'Operator pending mode' mappings";
    };
  };

  config = let
    filterNonNull = mappings: filterAttrs (name: value: value != null) mappings;
    globalsScript =
      mapAttrsFlatten (name: value: "let g:${name}=${toJSON value}")
      (filterNonNull cfg.globals);

    matchCtrl = it: match "Ctrl-(.)(.*)" it;
    mapKeyBinding = it: let
      groups = matchCtrl it;
    in
      if groups == null
      then it
      else "<C-${toUpper (head groups)}>${head (tail groups)}";
    mapVimBinding = prefix: mappings:
      mapAttrsFlatten (name: value: "${prefix} ${mapKeyBinding name} ${value}")
      (filterNonNull mappings);
  in {
    vim.configRC = ''
      ${concatStringsSep "\n" globalsScript}
      " Lua config from vim.luaConfigRC
      ${wrapLuaConfig
        (concatStringsSep "\n" [cfg.startLuaConfigRC 
                                cfg.luaConfigRC 
                                (keymaps2Lua cfg.keymaps)])}
    '';
  };
}
