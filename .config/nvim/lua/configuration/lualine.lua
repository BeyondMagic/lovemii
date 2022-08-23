-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Colours for the plugins.
local colors = require('../colours')

-- auto change color according to neovims mode
local mode_color = {
  n      = { 'Normal'           ,colors.blue },
  i      = { 'Insert'           ,colors.green },
  v      = { 'Visual'           ,colors.purple },
  [''] = { 'Visual Block'     ,colors.violet },
  V      = { 'Visual Line'      ,colors.purple },
  c      = { 'Command-Line'     ,colors.magenta },
  no     = { 'Operator-Pending' ,colors.darkblue },
  s      = { 'Select'           ,colors.orange },
  S      = { 'Select'           ,colors.info_yellow },
  [''] = { 'Select'           ,colors.dark_yellow },
  ic     = { 'Ins-Complete'     ,colors.yellow },
  R      = { 'Replace'          ,colors.red },
  Rv     = { 'Virtual'          ,colors.error_red },
  cv     = { 'Ex'               ,colors.vivid_blue },
  ce     = { 'Normal Ex'        ,colors.dark_blue },
  r      = { 'Hit-Enter'        ,colors.light_blue },
  rm     = { '--More'           ,colors.cyan },
  ['r?'] = { ':Confirm'         ,colors.light_green },
  ['!']  = { 'Shell'            ,colors.blue },
  t      = { 'Terminal'         ,colors.blue }
}

-- Conditional for a certain part of the bar to be rendered.
local conditions = {

  -- To see if the buffer is not empty.
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,

  -- To hide if is biggerr than certain width.
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,

  -- To check if is in git environment.
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,

  -- If it's a type of writing file.
  writing_file = function()
    if vim.bo.filetype == "md" or vim.bo.filetype == "text" or vim.bo.filetype == "markdown" then return true end
  end,

  -- To check if spell is activated.
  spell_activated = function ()
    if (vim.api.nvim_win_get_option(0, 'spell')) then return true end
  end

}

-- Lualine main configuration, very important to define.
local config = {

  -- Options main.
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',

    -- Filetypes to disable lualine for.
    disabled_filetypes = {
      statusline = { 'neo-tree' },       -- only ignores the ft for statusline.
      winbar     = { 'neo-tree' },           -- only ignores the ft for winbar.
    },


    -- enable global statusline (have a single statusline
    -- at bottom of neovim instead of one for  every window).
    -- This feature is only available in neovim 0.7 and higher.
    globalstatus = true,

    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },

    -- #. Sets how often lualine should refreash it's contents (in ms)
    refresh = {

      -- 1. The refresh option sets minimum time that lualine tries
          statusline = 50,

      -- 2. To maintain between refresh. It's not guarantied if situation
          tabline = 1000,

      -- 3. rises that lualine needs to refresh itself before this time
          winbar = 1000

       -- Also you can force lualine's refresh by calling refresh function
       --   like require('lualine').refresh()
    }

  },

  -- All sections of the bar.
  sections = {
    -- These are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },

  -- Just remove the defaults.
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },

  --tabline = {},
  --winbar = {
  --  -- These are to remove the defaults
  --  lualine_a = {},
  --  lualine_b = {},
  --  lualine_y = {},
  --  lualine_z = {},
  --  -- These will be filled later
  --  lualine_c = {},
  --  lualine_x = {},
  --},

  --inactive_winbar = {
  --  lualine_a = {},
  --  lualine_b = {},
  --  lualine_y = {},
  --  lualine_z = {},
  --  lualine_c = {},
  --  lualine_x = {},
  --},
  --extensions = {}

}

------------------------------------------------------
-- 1. Inserts a component in lualine_c at left section

local insert = {

  status = {

    left = function (component)
      table.insert(config.sections.lualine_c, component)
    end,

    -- Inserts a component in lualine_x ot right section
    right = function (component)
      table.insert(config.sections.lualine_x, component)
    end,

  },

  window = {

    left = function (component)
      table.insert(config.winbar.lualine_c, component)
    end,

    -- Inserts a component in lualine_x ot right section
    right = function (component)
      table.insert(config.winbar.lualine_x, component)
    end,

  }

}

-- 1. Statusline.
-----------------------------------------------------

-- #. To get back the name of the mode.
insert.status.left({
  function()
    return '▊ ' .. mode_color[vim.fn.mode()][1]
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()][2] }
  end,
  padding = { right = 1 },
})

-- #. Filesize component.
insert.status.left({
  'filesize',
  cond = conditions.buffer_not_empty,
})

insert.status.left({
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
})

insert.status.left({ 'location' })

insert.status.left({ 'progress', color = { fg = colors.fg, gui = 'bold' } })

insert.status.left({
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
})

-- Function to show the spell_language if spell si activated.
insert.status.left({
    function()
      return '  ' .. vim.api.nvim_get_option('spelllang')
    end,
    cond = conditions.spell_activated,
    color = { fg = colors.green, gui = 'bold' },
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
insert.status.left({
  function()
    return '%='
  end,
})

insert.status.left({
  -- Lsp server name .
  function()
    --local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return ''
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return ''
  end,
  icon = ' ',
  color = { fg = colors.fg, gui = 'bold' },
})

insert.status.right({
  -- This function serve to count all the words in the buffer and return a number.
  -- @return number The amount of words.
  function()
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  end,
  cond = conditions.writing_file,
  color = { fg = colors.purple, gui = 'bold' },
})

-- Add components to right sections
insert.status.right({
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
})

insert.status.right({
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
})

insert.status.right({
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
})

insert.status.right({
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

insert.status.right({
  function()
    return '▊'
  end,
  color = { fg = colors.bar },
  padding = { left = 1 },
})

----------------------------------------------------

-- 2. Winbar.
----------------------------------------------------

--insert.window.left({
--  function ()
--    return " I feel like dreaming!"
--  end,
--  color = { fg = colors.fg, bg = colors.bg_light, gui = 'bold' },
--})

----------------------------------------------------

-- Now don't forget to initialize lualine
lualine.setup(config)
