-- SOLARIZED OSAKA --
-- local M = {
--   "craftzdog/solarized-osaka.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
-- }

-- KANAGAWA --
-- local M = {
--   "rebelot/kanagawa.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
-- }

-- GRUVBOX --
local M = {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  opts = {}
}

-- NO CLOWN FIESTA --
-- local M = {
--   "aktersnurra/no-clown-fiesta.nvim",
--   lazy = false,
--   priority = 1000,
-- }

-- OXOCARBON --
-- local M = {
--   "nyoom-engineering/oxocarbon.nvim",
--   lazy = false,
--   priority = 1000,
-- }

function M.config()
  -- vim.cmd.colorscheme "solarized-osaka"
  vim.cmd.colorscheme "gruvbox"
  -- require("oxocarbon").setup({
  --   transparent=true
  -- })

  -- require("no-clown-fiesta").setup({
  --   transparent = true,
  -- })
  -- vim.cmd.colorscheme("oxocarbon")
  -- vim.cmd.colorscheme("kanagawa-dragon")
end

return M
