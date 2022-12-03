local M = {}

-- default configs
M.config = {
  undercurl = true,
  underline = true,
  bold = true,
  italic = false,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
}

function M.setup(config)
  M.config = vim.tbl_extend("force", M.config, config or {})
end

M.load = function()
  if vim.version().minor < 7 then
    vim.notify_once("fleet.nvim: you must use neovim 0.7 or higher")
    return
  end

  -- reset colors
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.g.colors_name = "fleet"
  vim.o.termguicolors = true

  local groups = require("fleet.groups").setup()

  -- add highlights
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M
