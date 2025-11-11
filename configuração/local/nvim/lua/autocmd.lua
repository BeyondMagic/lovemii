---@diagnostic disable: undefined-global

-- To save the current session (may be restored later).
-- autocmd! VimLeavePre * :mks! ~/.config/nvim/session.vim
vim.api.nvim_create_autocmd('VimLeavePre', {
	pattern = '*',
	desc = 'Save session on exit',
	command = ":mks! ~/.config/nvim/session.vim"
})

-- To switch themes.
-- vim.api.nvim_create_autocmd( 'Signal', {
--   pattern = 'SIGUSR1',
--   callback = function ()
--     vim.cmd( [[let &bg=(&bg=='light'?'dark':'light' ]] )
--     vim.cmd( [[colorscheme arcoiris-nvim]] )
--   end,
-- })

-- Determine the path for the temporary file.
-- Use the $NEOVIM_CD environment variable if set, otherwise fall back to a default.
local cd_file = vim.env.NEOVIM_CD or "/tmp/nvim_cd_path"

-- Create an autocommand that writes the current directory to the file on exit
vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	desc = "Write current directory to a temp file on exit",
	callback = function()
		-- ensure the directory exists
		if cd_file and cd_file ~= "" then
			-- vim.fn.getcwd() gets the current working directory
			vim.fn.writefile({ vim.fn.getcwd() }, cd_file)
		end
	end,
})

-- Disable highlighting for buffers that contain extremely long lines to avoid
-- highlighter crashes (mirrors VS Code's safeguard for huge single-line files).
local LONG_LINE_THRESHOLD = 20000

local function disable_highlight_on_long_lines(event)
	local bufnr = event.buf

	if vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "" then
		return
	end

	if vim.b[bufnr].__long_line_highlight_checked then
		return
	end

	vim.b[bufnr].__long_line_highlight_checked = true

	local has_long_line = vim.api.nvim_buf_call(bufnr, function()
		return vim.fn.search("\\%>" .. LONG_LINE_THRESHOLD .. "v", "nW") ~= 0
	end)

	if not has_long_line then
		return
	end

	vim.api.nvim_set_option_value("syntax", "OFF", { buf = bufnr })
	pcall(vim.treesitter.stop, bufnr)
	vim.b[bufnr].__long_line_highlight_disabled = true
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	desc = "Disable syntax highlighting when any line exceeds the long-line threshold",
	callback = disable_highlight_on_long_lines,
})
