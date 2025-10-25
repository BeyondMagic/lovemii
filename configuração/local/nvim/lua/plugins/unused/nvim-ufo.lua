return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		{ 'kevinhwang91/promise-async' },
	},
	config = {
		provider_selector = function(bufnr, filetype, buftype)
			return {'treesitter', 'indent'}
		end
	}
}
