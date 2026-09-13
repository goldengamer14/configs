return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
	    ensure_installed = {
		"lua",
		"c",
		"cpp",
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
	    },
                highlight = {
                    enable = true,
                },
            })
        end,
    },
}
