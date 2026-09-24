local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_module = lazypath .. "/lua/lazy/init.lua"
local settings = require("config.settings")

if not vim.uv.fs_stat(lazy_module) then
    if vim.uv.fs_stat(lazypath) then
        vim.fn.delete(lazypath, "rf")
    end
    vim.fn.mkdir(vim.fn.fnamemodify(lazypath, ":h"), "p")
    local result = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Failed to install lazy.nvim: " .. result)
    end
end

if not package.path:find(lazypath, 1, true) then
    package.path = lazypath .. "/lua/?.lua;" .. lazypath .. "/lua/?/init.lua;" .. package.path
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = require("config.plugins"),
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { settings.colorscheme },
    },
    change_detection = {
        notify = false,
    },
    checker = {
        enabled = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        border = "rounded",
    },
})