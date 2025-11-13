---@diagnostic disable: undefined-global

local M = {}

local LONG_LINE_THRESHOLD = 20000
local registered = false

local function disable_highlight_on_long_lines(event)
	local bufnr = event.buf

	if vim.api.nvim_buf_get_option(bufnr, 'buftype') ~= '' then
		return
	end

	if vim.b[bufnr].__long_line_highlight_checked then
		return
	end

	vim.b[bufnr].__long_line_highlight_checked = true

	local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ''

	if #first_line < LONG_LINE_THRESHOLD then
		return
	end

	vim.api.nvim_set_option_value('syntax', 'OFF', { buf = bufnr })
	pcall(vim.treesitter.stop, bufnr)
	vim.b[bufnr].__long_line_highlight_disabled = true
end

function M.setup()
	if registered then
		return
	end

	registered = true

	vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
		desc = 'Disable syntax highlighting when any line exceeds the long-line threshold',
		callback = disable_highlight_on_long_lines,
	})
end

return M
