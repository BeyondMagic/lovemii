local colorscheme_name = 'arcoiris'

---Returns the color set by the current colorscheme for the `attr` attribute of
---the `hlgroup_name` highlight group in hexadecimal format.
---@param hlgroup_name  string
---@param attr  '"fg"' | '"bg"'
---@return string
local get_hex = function(hlgroup_name, attr)
  local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
  local hex        = vim.fn.synIDattr(hlgroup_ID, attr)
  return hex ~= "" and hex or "NONE"
end

-- TODO: discover what this command means.
--vim.api.nvim_create_autocmd('ColorScheme', {
--  callback = function() vim.api.nvim_set_hl(…) end,
--  group = vim.api.nvim_create_augroup('config', {clear = false}),
--  pattern = 'highlite',
--})

-- Allow transparency.
vim.opt.termguicolors = true

-- Setting our theem set.
-- 1. 'light' for white theme.
-- 2. 'dark' for dark theme.
vim.api.nvim_set_option('background', 'dark')

-- Set colorscheme theme.
vim.cmd.colorscheme(colorscheme_name)
local colours = require('colourschemes.' .. colorscheme_name .. '.colours.dark')

COLOUR = {}
for k, v in pairs(colours) do
  COLOUR[k] = v[1]
end
