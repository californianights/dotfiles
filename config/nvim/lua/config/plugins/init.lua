local M = {}

local modules = {
    "config.plugins.ui",
    "config.plugins.editor",
    "config.plugins.ai",
    "config.plugins.search",
    "config.plugins.treesitter",
    "config.plugins.lsp",
    "config.plugins.git",
}

for _, module in ipairs(modules) do
    vim.list_extend(M, require(module))
end

return M