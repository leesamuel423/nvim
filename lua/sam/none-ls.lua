local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local null_ls = require("null-ls")

  -- Create an augroup for format on save
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  -- Register sources
  local sources = {
    -- Python formatting
    null_ls.builtins.formatting.black.with({
      command = "black",
      args = { 
        "--quiet",
        "--line-length",
        "79",
        "--preview",
        "-" 
      },
      to_stdin = true,
    }),
    null_ls.builtins.formatting.isort.with({
      command = "isort",
      args = { 
        "--quiet",
        "--profile=black",
        "--line-length=79",
        "-" 
      },
      to_stdin = true,
    }),
  }

  null_ls.setup({
    sources = sources,
    debug = true,
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
            if filetype == "python" then
              -- Remove trailing whitespace
              vim.cmd([[%s/\s\+$//e]])
              -- Format synchronously
              vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(c)
                  return c.name == "null-ls"
                end,
                timeout_ms = 10000,
                async = false,
              })
            end
          end,
        })
      end
    end,
  })

  -- Add a command to check if formatters are available
  vim.api.nvim_create_user_command("CheckFormatters", function()
    local black_exists = vim.fn.executable("black") == 1
    local isort_exists = vim.fn.executable("isort") == 1
    print(string.format("black: %s, isort: %s", 
      black_exists and "✓" or "✗",
      isort_exists and "✓" or "✗"
    ))
  end, {})
end

return M
