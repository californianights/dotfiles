local map = vim.keymap.set

map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit Neovim" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
map("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<leader>-", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })

map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bw", "<cmd>Bwipeout<cr>", { desc = "Wipe Buffer" })
map("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI actions", silent = true })
map("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI chat", silent = true })
map("v", "<leader>ac", ":CodeCompanionChat Add<CR>", { desc = "Add to AI chat", silent = true })
map("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "AI inline", silent = true })
map("v", "<leader>ai", ":CodeCompanion<CR>", { desc = "AI inline", silent = true })

map("v", "<leader>at", ":AddGoTags<CR>", { desc = "Add Go struct tags", silent = true })
map("v", "<leader>rt", ":RemoveGoTags<CR>", { desc = "Remove Go struct tags", silent = true })
