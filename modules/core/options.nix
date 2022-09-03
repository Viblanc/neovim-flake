{ pkgs, lib, config, ... }:
with lib;
with builtins;

let
  cfg = config.vim;
in {
  options.vim = {
    colourTerm = mkOption {
      default = true;
      description = "Set vim up for 256 colours";
      type = types.bool;
    };

    scrollOffset = mkOption {
      default = 5;
      description = "Start scrolling this number of lines from the top or bottom of the page";
      type = types.int;
    };

    syntaxHighlighting = mkOption {
      default = true;
      description = "Enable syntax highlighting";
      type = types.bool;
    };

    mapLeaderSpace = mkOption {
      default = true;
      description = "Set leader key to space";
      type = types.bool;
    };

    useSystemClipboard = mkOption {
      default = true;
      description = "Make use of the clipboard for default yank and paste operations";
      type = types.bool;
    };

    tabWidth = mkOption {
      default = 2;
      description = "Set the width of tabs to 2";
      type = types.int;
    };

    autoIndent = mkOption {
      default = true;
      description = "Enable auto indent";
      type = types.bool;
    };

    smartIndent = mkOption {
      default = true;
      description = "Enable smart indent";
      type = types.bool;
    };

    cmdHeight = mkOption {
      default = 0;
      description = "Set height of the command pane";
      type = types.int;
    };

    updateTime = mkOption {
      default = 200;
      description = "Number of ms until CursorHold event is triggered";
      type = types.int;
    };

    timeoutLen = mkOption {
      default = 500;
      description="Time in ms to wait for a mapped source to complete";
      type = types.int;
    };

    lineNumbers = mkOption {
      default = false;
      description = "Enable line numbers";
      type = types.bool;
    };

    ignoreCase = mkOption {
      default = true;
      description = "Enable case-insensitive search";
      type = types.bool;
    };

    preventJunkFiles = mkOption {
      default = true;
      description = "Prevent swapfile and backupfile from being created";
      type = types.bool;
    };

    undoFile = mkOption {
      default = true;
      description = "Create undo file";
      type = types.bool;
    };

    lastStatus = mkOption {
      default = 3;
      description = "Enable status line";
      type = types.int;
    };

    winBar = mkOption {
      default = "%=%m %f";
      description = "Enable winbar";
      type = types.string;
    };

    enableFolding = mkOption {
      default = true;
      description = "Enable folding";
      type = types.bool;
    };

    disableBuiltins = mkOption {
      default = true;
      description = "Disable unused built-in plugins and providers";
      type = types.bool;
    };
  };

  config =
    let
      writeIf = cond: msg: if cond then msg else "";
    in {
      vim.configRC = ''
        set encoding=utf-8
        set expandtab
        set smarttab
        set shiftwidth=${toString cfg.tabWidth}
        set tabstop=${toString cfg.tabWidth}
        set softtabstop=${toString cfg.tabWidth}
        set cmdheight=${toString cfg.cmdHeight}
        set updatetime=${toString cfg.updateTime}
        set timeoutlen=${toString cfg.timeoutLen}
        set hidden
        set cursorline
        set cursorlineopt=number
        set completeopt=menu,menuone,preview,noinsert
        ${writeIf cfg.colourTerm "set termguicolors"}
        ${writeIf cfg.syntaxHighlighting "syntax on"}
        ${writeIf cfg.autoIndent "set ai"}
        ${writeIf cfg.smartIndent "set si"}
        ${writeIf cfg.lineNumbers "set number"}
        ${writeIf cfg.mapLeaderSpace ''
          let mapleader=" "
          let maplocalleader=" "
        ''}
        ${writeIf cfg.ignoreCase ''
          set ignorecase
          set smartcase
        ''}
        ${writeIf cfg.preventJunkFiles ''
          set noswapfile
          set nobackup
          set nowritebackup
        ''}
        ${writeIf cfg.undoFile "set undofile"}
        ${writeIf cfg.useSystemClipboard "set clipboard+=unnamedplus"}
        ${writeIf cfg.enableFolding ''
          set foldenable
          set foldlevel=99
          set foldlevelstart=99
          set foldcolumn=1
        ''}
        ${writeIf cfg.disableBuiltins ''
          let g:loaded_gzip = 1
          let g:loaded_zip = 1
          let g:loaded_zipPlugin = 1
          let g:loaded_tar = 1
          let g:loaded_tarPlugin = 1
          let g:loaded_getscript = 1
          let g:loaded_getscriptPlugin = 1
          let g:loaded_vimball = 1
          let g:loaded_vimballPlugin = 1
          let g:loaded_2html_plugin = 1
          let g:loaded_matchit = 1
          let g:loaded_matchparen = 1
          let g:loaded_logiPat = 1
          let g:loaded_rrhelper = 1
          let g:loaded_netrw = 1
          let g:loaded_netrwPlugin = 1
          let g:loaded_netrwSettings = 1
          let g:loaded_netrwFileHandlers = 1
          let g:loaded_perl_provider = 0
          let g:loaded_node_provider = 0
          let g:loaded_ruby_provider = 0
          let g:loaded_python_provider = 0
          let g:loaded_python3_provider = 0
        ''}
      '';
    };
}
