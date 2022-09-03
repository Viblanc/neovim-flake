{ pkgs, lib, config, ... }:
with lib;
with builtins;

let
  cfg = config.vim;
in {
  config = {
    vim.luaConfigRC = ''
      local modes = {
        n = "RW",
        no = "RO",
        v = "**",
        V = "**",
        s = "S",
        S = "SL",
        i = "**",
        ic = "**",
        R = "RA",
        Rv = "RV",
        c = "VIEX",
        cv = "VIEX",
        ce = "EX",
        r = "r",
        rm = "r",
        ["r?"] = "r",
        ["!"] = "!",
        t = "t"
      }

      local function color()
        local mode = vim.api.nvim_get_mode().mode
        local mode_color = "%#StatusLine#"
        if mode == "n" then
          mode_color = "%#StatusNormal#"
        elseif mode == "i" or mode == "ic" then
          mode_color = "%#StatusInsert#"
        elseif mode == "v" or mode == "V" then
          mode_color = "%#StatusVisual#"
        elseif mode == "R" then
          mode_color = "%#StatusReplace#"
        elseif mode == "c" then
          mode_color = "%#StatusCommand#"
        elseif mode == "t" then
          mode_color = "%#StatusTerminal#"
        end
        return mode_color
      end

      local function get_git_status()
        local branch = vim.b.gitsigns_status_dict or { head = "" }
        local is_head_empty = branch.head == ""
        if is_head_empty then
          return ""
        else
          return string.format("(λ • #%s)", branch.head)
        end
      end

      local function get_lsp_diagnostics()
        local buf_clients = vim.lsp.buf_get_clients(0)
        if (next(buf_clients) == nil) then
          return "";
        end

        local diagnostics = vim.diagnostic.get(0)
        local count = { 0, 0, 0, 0 }
        for _, diagnostic in ipairs(diagnostics) do
          count[diagnostic.severity] = count[diagnostic.severity] + 1
        end

        local result = {
          errors = count[vim.diagnostic.severity.ERROR],
          warnings = count[vim.diagnostic.severity.WARN],
          info = count[vim.diagnostic.severity.INFO],
          hints = count[vim.diagnostic.severity.HINT]
        }

        return string.format(" %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s ", result.warnings, result.errors)
      end

      Statusline = {}

      Statusline.statusline = function()
        return table.concat({
          color(),
          string.upper(string.format(" %s ", modes[vim.api.nvim_get_mode().mode])),
          "%#StatusLine#",
          " %f ",
          "%#StatusPosition#",
          get_git_status(),
          "%=",
          get_lsp_diagnostics(),
          "%#StatusPosition#",
          " %l:%c "
        })
      end
    '';

    vim.configRC = ''
      set statusline=%!v:lua.Statusline.statusline()
    '';
  };
}
