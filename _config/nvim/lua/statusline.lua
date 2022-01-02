local gl = require('galaxyline')
-- get my theme in galaxyline reo
-- local colors = require('galaxyline.theme').default
local colors = {
    bg = 'none',
    fg = '#1B1615',
    yellow = '#DCDCAA',
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    green = '#608B4E',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C586C0',
    magenta = '#D16D9E',
    grey = '#858585',
    blue = '#569CD6',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    red = '#D16969',
    error_red = '#F44747',
    info_yellow = '#FFCC66'
}
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

gls.left[1] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = { 'Normal', colors.blue },
                i = { 'Insert', colors.green },
                v = { 'Visual', colors.purple },
                [''] = { 'Visual Block', colors.purple },
                V = { 'Visual Line', colors.purple },
                c = { 'Command-Line', colors.magenta },
                no = { 'Operator-Pending', colors.blue },
                s =  { 'Select', colors.orange },
                S = { 'Select', colors.orange },
                [''] = { 'Select', colors.orange },
                ic = { 'Ins-Complete', colors.yellow },
                R = { 'Replace', colors.red },
                Rv = { 'Virtual', colors.red },
                cv = { 'Ex', colors.blue },
                ce = { 'Normal Ex', colors.blue },
                r = { 'Hit-Enter', colors.cyan },
                rm = { '--More', colors.cyan },
                ['r?'] = { ':Confirm', colors.cyan },
                ['!'] = { 'Shell', colors.blue },
                t = { 'Terminal', colors.blue }
            }
            vim.cmd('hi GalaxyViMode guifg=' .. colors.fg .. ' guibg=' .. mode_color[vim.fn.mode()][2] .. ' gui=bold')
            return '  ' .. mode_color[vim.fn.mode()][1] .. ' '
        end,
--        highlight = {colors.red, colors.bg}
    }
}
print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, 'ts')

gls.left[2] = {
    GitIcon = {
        provider = function()
            return '   '
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.left[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
         separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.left[4] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '    ',
        highlight = {colors.green, colors.bg}
    }
}
gls.left[5] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = '  柳 ',
        highlight = {colors.blue, colors.bg}
    }
}
gls.left[6] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '    ',
        highlight = {colors.red, colors.bg}
    }
}
gls.left[7] = {
    SpellLanguage = {
        provider = function()
	  if (vim.api.nvim_win_get_option(0, 'spell')) then
            return vim.api.nvim_get_option('spelllang')
	  end
        end,
        separator = ' ',
      	icon = '    ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.light_green, colors.bg}
    }
}

gls.right[1] = {
    DiagnosticError = {provider = 'DiagnosticError', icon = '    '}
}
gls.right[2] = {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '    '}}

gls.right[3] = {
    DiagnosticHint = {provider = 'DiagnosticHint', icon = '    '}
}

gls.right[4] = {DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '    '}}

gls.right[5] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = '  ',
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = '  ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
	separator_highlight = {'NONE', colors.bg},
        highlight = {colors.blue, colors.bg}
    }
}

gls.right[8] = {
    Tabstop = {
        provider = function()
            return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
        end,
        condition = condition.hide_in_width,
        separator = ' ',
	separator_highlight = {'NONE', colors.bg},
        highlight = {colors.light_green, colors.bg}
    }
}

gls.right[9] = {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.green, colors.bg}
    }
}

gls.right[10] = {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.cyan, colors.bg}
    }
}

gls.right[11] = {
    Space = {
        provider = function()
            return '=F'
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.cyan, colors.bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.short_line_left[2] = {
    SFileName = {provider = 'SFileName', condition = condition.buffer_not_empty}
}

gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon'}}

