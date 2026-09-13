return {
    {
	-- This helps with SSH Tunneling and Copying to Clipboard
	'ojroques/vim-oscyank',
    },
    {
	-- Git Plugin	
	'tpope/vim-fugitive',
    },
    {
	-- Show CSS Colors
	'brenoprata10/nvim-highlight-colors',
	config = function()
	    require('nvim-highlight-colors').setup({})
	end
    },
}

