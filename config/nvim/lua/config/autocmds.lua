local group = vim.api.nvim_create_augroup("user_config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = group,
    desc = "Reload file changed outside Neovim",
    command = "checktime",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    desc = "Restore last cursor position",
    callback = function(args)
        local line = vim.fn.line([['"]])
        local last_line = vim.api.nvim_buf_line_count(args.buf)
        if line > 0 and line <= last_line then
            vim.api.nvim_win_set_cursor(0, { line, 0 })
        end
    end,
})