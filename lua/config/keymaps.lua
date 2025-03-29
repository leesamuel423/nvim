-- Utility functions and settings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.g.mapleader = " " -- Set the leader key to space

-- General mappings
map("n", "<C-s>", ":w<CR>", { noremap = true })                           -- Save file in normal mode
map("i", "<C-s>", "<C-o>:write<CR>a", { noremap = true })                 -- Save file in insert mode
map("n", "<leader>nh", ":nohl<CR>", { desc = "clear search highlights" }) -- Clear search highlights
map("n", "<C-q>", "gg<S-v>G", opts)                                       -- Select all text

-- Source in live setting
map("n", "<space><space>x", "<cmd>source %<CR>")
map("n", "<space>x", ":.lua <CR>")
map("v", "<space>x", ":.lua <CR>")

-- Navigation
-- Map Ctrl+hjkl to arrow keys in insert mode
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Keep search terms in the middle of the screen
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- Window management
map("n", "<leader>sv", ":vsplit<CR>", { desc = "split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "split window horizontally" })
map("n", "<leader>sb", "<C-w>=", { desc = "make windows equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "close current split" })

-- Tab management
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close current tab" })
map("n", "L", "<cmd>tabn<CR>", { desc = "go to next tab" })
map("n", "H", "<cmd>tabp<CR>", { desc = "go to prev tab" })

-- Text manipulation
map("v", "J", ":m '>+1<CR>gv=gv", opts) -- Move selected text down
map("v", "K", ":m '<-2<CR>gv=gv", opts) -- Move selected text up

-- File explorer
map("n", "<leader>pv", vim.cmd.Oil, opts) -- Open file explorer (using Oil.nvim)

-- Telescope (fuzzy finder)
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "fuzzy find files in cwd" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "fuzzy find recent files" })
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "find string in cwd" })
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "find string under cursor in cwd" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "find todos" })
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "show LSP definitions" })
map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "show LSP implementations" })
map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "show LSP type definitions" })
map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "show buffer diagnostics" })

-- LSP actions
map("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "show line diagnostics" })
map("n", "<leader>lk", vim.diagnostic.goto_prev, { desc = "go to previous diagnostic" })
map("n", "<leader>lj", vim.diagnostic.goto_next, { desc = "go to next diagnostic" })

-- LSP Keymapping
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)

-- Easy Align --
map("x", "ga", "<Plug>(EasyAlign)")
map("n", "ga", "<Plug>(EasyAlign)")

-- Commented out (unused) keymap
-- keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "restart LSP" })
