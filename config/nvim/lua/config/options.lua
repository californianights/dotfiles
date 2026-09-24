local settings = require("config.settings")
local opt = vim.opt

vim.g.mapleader = settings.leader
vim.g.maplocalleader = settings.localleader

opt.number = true
opt.relativenumber = settings.use_relative_number
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.pumheight = 10

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.cmdheight = 2

opt.wrap = false
opt.linebreak = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.mouse = ""
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = { "menu", "menuone", "noselect" }
opt.undofile = true
opt.confirm = true
opt.inccommand = "split"
opt.laststatus = 3
opt.showmode = false
opt.showtabline = 2
opt.winborder = "rounded"

opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}
opt.fillchars = {
    eob = " ",
}
