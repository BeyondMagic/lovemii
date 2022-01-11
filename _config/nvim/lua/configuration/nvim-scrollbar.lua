require("scrollbar").setup()

require("hlslens").setup({
    build_position_cb = function(plist, bufnr, changedtick, pattern)
        require("scrollbar").search_handler.show(plist.start_pos)
    end,
})

-- vim.cmd([[
--     augroup scrollbar_search_hide
--         autocmd!
--         autocmd CmdlineLeave : lua require('scrollbar').search_handler.hide()
--     augroup END
-- ]])
