let
  colors = {
    bg0 = "#090c0f";
    bg1 = "#121619";
    bg2 = "#2a2a2a";
    bg3 = "#484848";
    fg0 = "#f1efce";
    fg1 = "#f4f4e8";
    fg2 = "#f0f0f0";
    orange = "#faa97a";
    red = "#fa8585";
    pink = "#f97aa6";
    punk = "#f169d4";
    lightpink = "#ffafd2";
    lightpurple = "#d4bbff";
    purple = "#be95ff";
    darkblue = "#4589ff";
    blue = "#669bf7";
    cyan = "#80c0ff";
    teal = "#3ddbd9";
    green = "#68c89c";
    none = "NONE";
  };
in {
  Normal = { fg = colors.fg0; bg = colors.bg1; };
  Visual = { fg = colors.none; bg = colors.bg2; };
  VisualNOS = { fg = colors.none; bg = colors.bg2; };

  Comment = { fg = colors.bg3; bg = colors.none; };
  Number = { fg = colors.cyan; bg = colors.none; };
  Float = { fg = colors.cyan; bg = colors.none; };
  Boolean = { fg = colors.darkblue; bg = colors.none; };
  String = { fg = colors.teal; bg = colors.none; };
  Constant = { fg = colors.fg0; bg = colors.none; };
  Character = { fg = colors.purple; bg = colors.none; };
  Delimiter = { fg = colors.fg1; bg = colors.none; };
  Statement = { fg = colors.blue; bg = colors.none; };

  Conditional = { fg = colors.darkblue; bg = colors.none; bold = true; };
  Repeat = { fg = colors.cyan; bg = colors.none; bold = true; };
  Todo = { fg = colors.green; bg = colors.fg1; };
  Function = { fg = colors.pink; bg = colors.none; bold = true; };

  Define = { fg = colors.blue; bg = colors.none; };
  Include = { fg = colors.pink; bg = colors.none; };
  PreCondit = { fg = colors.blue; bg = colors.none; };
  PreProc = { fg = colors.blue; bg = colors.none; };

  Identifier = { fg = colors.fg0; bg = colors.none; };
  Type = { fg = colors.purple; bg = colors.none; };
  Operator = { fg = colors.lightpink; bg = colors.none; };
  Keyword = { fg = colors.purple; bg = colors.none; };
  Exception = { fg = colors.red; bg = colors.none; };
  Structure = { fg = colors.blue; bg = colors.none; };
  Error = { fg = colors.red; bg = colors.none; };
  ErrorMsg = { fg = colors.red; bg = colors.none; };

  ColorColumn = { fg = colors.none; bg = colors.bg2; };

  LineNr = { fg = colors.bg3; bg = colors.bg1; };
  CursorLine = { fg = colors.none; bg = colors.bg2; };
  CursorLineNr = { fg = colors.fg0; bg = colors.bg1; };
  CursorColumn = { fg = colors.none; bg = colors.bg2; };
  NormalFloat = { fg = colors.fg2; bg = colors.bg0; };

  Directory = { fg = colors.teal; bg = colors.none; };

  DiffAdd = { fg = colors.none; bg = colors.green; };
  DiffDelete = { fg = colors.none; bg = colors.pink; };
  DiffChange = { fg = colors.none; bg = colors.purple; };
  #DiffText = { fg = colors.none; bg = colors.base18; };

  VertSplit = { fg = colors.bg0; bg = colors.bg1; };
  Folded = { fg = colors.bg3; bg = colors.bg0; };

  FoldColumn = { fg = colors.bg0; bg = colors.bg1; };
  MatchParen = { fg = colors.fg1; bold = true; underline = true; };

  ModeMsg = { fg = colors.fg0; bg = colors.none; bold = true; };
  MoreMsg = { fg = colors.fg0; bg = colors.none; };
  NonText = { fg = colors.bg0; bg = colors.none; };

  Pmenu = { fg = colors.fg0; bg = colors.bg0; };
  PmenuSbar = { fg = colors.fg0; bg = colors.bg0; };
  PmenuSel = { fg = colors.pink; bg = colors.bg1; };
  PmenuThumb = { fg = colors.teal; bg = colors.bg1; };

  Search = { fg = colors.bg2; bg = colors.teal; };
  IncSearch = { fg = colors.fg1; bg = colors.pink; };

  Special = { fg = colors.fg0; bg = colors.none; };

  TabLine = { fg = colors.fg0; bg = colors.bg2; };
  TabLineFill = { fg = colors.fg0; bg = colors.bg2; };
  TabLineSel = { fg = colors.teal; bg = colors.bg2; };
  WildMenu = { fg = colors.teal; bg = colors.bg2; bold = true; };

  Title = { fg = colors.fg0; bg = colors.none; bold = true; };
  Question = { fg = colors.fg0; bg = colors.none; };
  WarningMsg = { fg = colors.bg1; bg = colors.pink; };
  SignColumn = { fg = colors.bg2; bg = colors.bg1; };

  Conceal = { fg = colors.none; bg = colors.none; };
  # Ignore = { fg = colors.pink; bg = colors.bg0; };

# LSP
  DiagnosticWarn = { fg = colors.teal; };
  DiagnosticUnderlineWarn = { fg = colors.teal; undercurl = true; };
  LspDiagnosticsDefaultWarning = { link = "DiagnosticWarn"; };
  LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn"; };

  DiagnosticError = { fg = colors.red; };
  DiagnosticUnderlineError = { fg = colors.red; undercurl = true; };
  LspDiagnosticsDefaultError = { link = "DiagnosticError"; };
  LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError"; };

  DiagnosticInfo = { fg = colors.lightpurple; };
  DiagnosticUnderlineInfo = { fg = colors.lightpurple; undercurl = true; };
  LspDiagnosticsDefaultInformation = { link = "DiagnosticInfo"; };
  LspDiagnosticsUnderlineInformation = { link = "DiagnosticUnderlineInfo"; };

  DiagnosticHint = { fg = colors.lightpurple; };
  DiagnosticUnderlineHint = { fg = colors.lightpurple; undercurl = true; };
  LspDiagnosticsDefaultHint = { link = "DiagnosticHint"; };
  LspDiagnosticsUnderlineHint = { link = "DiagnosticUnderlineHint"; };

# Tree-sitter
  TSAttribute = { fg = colors.cyan; };
  TSBoolean = { link = "Boolean"; };
  TSCharacter = { link = "Character"; };
  TSComment = { link = "Comment"; };
  TSConditional = { link = "Conditional"; };
  TSConstBuiltin = { fg = colors.darkblue; };
  TSConstMacro = { fg = colors.darkblue; };
  TSConstant = { fg = colors.purple; };
  TSConstructor = { fg = colors.pink; };
  TSError = { link = "Error"; };
  TSException = { link = "Exception"; };
  TSField = { fg = colors.lightpurple; };
  TSFloat = { link = "Float"; };
  TSFuncMacro = { fg = colors.darkblue; };
  TSFuncBuiltin = { fg = colors.pink; bold = true; italic = true; };
  TSFunction = { link = "Function"; };
  TSInclude = { link = "Include"; };
  TSKeyword = { link = "Keyword"; };
  TSKeywordFunction = { fg = colors.purple; bold = true; };
  TSKeywordOperator = { fg = colors.teal; };
  TSKeywordReturn = { link = "TSKeyword"; };
  TSLabel = { fg = colors.red; };
  TSMethod = { fg = colors.blue; bold = true; };
  TSNamespace = { fg = colors.purple; bold = true; };
  # TSNone = { fg = colors.base56; };
  TSNumber = { link = "Number"; };
  TSOperator = { link = "Operator"; };
  TSParameter = { fg = colors.fg0; };
  TSParameterReference = { fg = colors.fg0; };
  TSProperty = { fg = colors.blue; };
  TSPunctDelimiter = { fg = colors.lightpink; };
  TSPunctBracket = { fg = colors.fg0; };
  TSPunctSpecial = { fg = colors.fg0; };
  TSRepeat = { link = "Repeat"; };
  TSString = { link = "String"; };
  TSStringSpecial = { fg = colors.cyan; };
  TSStringEscape = { fg = colors.red; };
  TSStringRegex = { fg = colors.blue; };
  TSSymbol = { fg = colors.red; };
  TSTag = { fg = colors.fg0; };
  TSTagDelimiter = { fg = colors.red; };
  TSTitle = { link = "Title"; };
  TSType = { link = "Type"; };
  TSTypeBuiltin = { fg = colors.blue; };
  TSVariable = { fg = colors.fg0; bold = true; };
  TSVariableBuiltin = { fg = colors.fg0; };

  StatusLine = { fg = colors.bg3; bg = colors.bg1; };
  StatusInsert = { fg = colors.bg1; bg = colors.pink; };
  StatusVisual = { fg = colors.bg1; bg = colors.purple; };
  StatusPosition = { fg = colors.fg1; bg = colors.bg1; };

## Plugins

# Telescope
  TelescopeNormal = { fg = colors.fg0; bg = colors.bg0; };
  TelescopeMatching = { fg = colors.pink; bold = true; };
  TelescopeSelection = { bg = colors.bg1; };
  TelescopePromptPrefix = { fg = colors.purple; };
  TelescopeSelectionCaret = { fg = colors.purple; };
  TelescopePromptTitle = { fg = colors.fg0; bold = true; };
  TelescopePromptBorder = { fg = colors.bg0; bg = colors.bg0; };
  TelescopePreviewBorder = { fg = colors.bg0; bg = colors.bg0; };
  TelescopeResultsBorder = { fg = colors.bg0; bg = colors.bg0; };

# gitsigns
  GitSignsAdd = { fg = colors.green; };
  GitSignsChange = { fg = colors.purple; };
  GitSignsDelete = { fg = colors.pink; };

# cmp
  CmpItemAbbr = { fg = colors.bg3; };
  CmpItemAbbrMatch = { fg = colors.fg0; bold = true; };
  CmpItemAbbrMatchFuzzy = { fg = colors.fg0; };
  CmpItemKindVariable = { link = "TSVariable"; };
  CmpItemKindConstructor = { link = "TSConstructor"; };
  CmpItemKindField = { link = "TSField"; };
  CmpItemKindInterface = { link = "CmpItemKindVariable"; };
  CmpItemKindText = { link = "CmpItemKindVariable"; };
  CmpItemKindOperator = { link = "TSOperator"; };
  CmpItemKindProperty = { link = "TSProperty"; };
  CmpItemKindUnit = { link = "TSKeyword"; };
  CmpItemKindFunction = { link = "TSFunction"; };
  CmpItemKindMethod = { link = "TSMethod"; };
  CmpItemKindStruct = { link = "TSStruct"; };
  CmpItemKindSnippet = { fg = colors.blue; };
}
