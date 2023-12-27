return {
	'numToStr/Comment.nvim',
	opts = {},
	config = function()
		require('Comment').setup({
			toggler = {
				line = '<C-Q>',
			},
			opleader = {
				line = '<C-Q>',
			}
		})
	end
}
