return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },

        opts = {
            formatters_by_ft = {
                lua = { "stylua" },

                python = { "ruff_format" },

                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },

                html = { "prettier" },
                css = { "prettier" },

                c = { "clang-format" },
                cpp = { "clang-format" },
            },
        },

        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({
                        async = true,
                        lsp_format = "fallback",
                    })
                end,
                mode = "",
                desc = "Format file/selection",
            },
        },
    },
}
