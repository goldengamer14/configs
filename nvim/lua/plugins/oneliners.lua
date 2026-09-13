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
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            local autopairs = require("nvim-autopairs")
            local cmp = require("cmp")

            autopairs.setup({})

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )
        end,
    },}

