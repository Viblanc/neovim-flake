{ pkgs, lib, config, ... }:
let
  cfg = config.vim.telescope;
in {
  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      telescope-nvim
      plenary-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim
    ];

    vim.keymaps = [
      {
        prefix = "<Leader>";
        mode = "n";
        "<Space>" = "<cmd>Telescope fd<CR>";
        options = [ "silent" ];
      }
    ];

    vim.luaConfigRC = ''
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          prompt_prefix = "❯ ",
          selection_caret = "❯ ",
          borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"}
        },
        pickers = {
          find_files = {
             find_command = {"fd", "--type", "f", "--strip-cwd-prefix"},
             theme = "ivy"
          },
          fd = {
            theme = "ivy"
          },
          live_grep = {
            theme = "ivy"
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true
          },
          fzf = { 
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
          }
        }
      })

      local extensions = {"file_browser", "fzf"}
      for _, extension in ipairs(extensions) do
        telescope.load_extension(extension)
      end
    '';
  };
}
