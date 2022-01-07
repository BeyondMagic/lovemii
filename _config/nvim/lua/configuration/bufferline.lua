require('bufferline').setup {
  highlights = {
    fill = {
--      guifg = '<color-value-here>',
      guibg = '#222222',
    },
    background = {
      guifg = '#AAAAAA',
      guibg = '#333333',
    },
--    tab = {
--      guifg = '<color-value-here>',
--      guibg = '#fffff0',
--    },
  },
  options = {
    numbers = "both",
    -- numbers = { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
    -- mappings = false,
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '█ ',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    offsets = {{filetype = "NvimTree", text = "Explore", text_align = "center"}},
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'extension',
    custom_areas = {
      right = function()
        local result = {}
        -- local error = vim.diagnostic.get(0, [[Error]])
        -- local warning = vim.diagnostic.get(0, [[Warning]])
        -- local info = vim.diagnostic.get(0, [[Information]])
        -- local hint = vim.diagnostic.get(0, [[Hint]])

        local nvim_diagnostic = function()
          local diagnostics = vim.diagnostic.get(0)
          local count = { 0, 0, 0, 0 }
          for _, diagnostic in ipairs(diagnostics) do
            count[diagnostic.severity] = count[diagnostic.severity] + 1
          end
          return count[vim.diagnostic.severity.ERROR],
            count[vim.diagnostic.severity.WARN],
            count[vim.diagnostic.severity.INFO],
            count[vim.diagnostic.severity.HINT]
        end

        local data = nvim_diagnostic()

        if data.error ~= 0 then
        result[1] = {text = "  " .. data[0], guifg = "#EC5241"}
        end

        if data.warning ~= 0 then
        result[2] = {text = "  " .. data[1], guifg = "#EFB839"}
        end

        if data.hint ~= 0 then
        result[3] = {text = "  " .. data[2], guifg = "#A3BA5E"}
        end

        if data.info ~= 0 then
        result[4] = {text = "  " .. data[3], guifg = "#7EA9A7"}
      end
      return result
    end
    }
  }
}
