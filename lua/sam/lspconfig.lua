return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      -- List of servers to setup
      local servers = {
        -- Python
        "pyright",  -- Python language server
        "ruff",    -- Python linter (replaced ruff_lsp)
        "taplo",
        -- Java
        "jdtls",                 -- Java language server
        -- JavaScript/TypeScript
        "ts_ls",                -- TypeScript server (replaced tsserver)
        -- C++
        "clangd",                -- C++ language server
        -- CSS
        "cssls",                 -- CSS language server
        "tailwindcss",           -- Tailwind CSS support
        -- HTML
        "html",                  -- HTML language server
        -- JSON
        "jsonls",                -- JSON language server
        -- Lua
        "lua_ls",                -- Lua language server
        -- Shell scripting
        "bashls",                -- Bash language server
        -- YAML
        "yamlls",                -- YAML language server
        -- Additional useful servers
        "emmet_language_server", -- Emmet support for HTML/CSS
        "dockerls",              -- Docker language server
        "sqlls",                 -- SQL language server
        "denols",                -- Deno language server
        "gopls",                 -- Golang
      }
      -- Setup all servers
      for _, server in ipairs(servers) do
        if server ~= "jdtls" then -- Skip jdtls as we configure it separately
          lspconfig[server].setup({
            capabilities = capabilities,
          })
        end
      end

      -- Java (jdtls) configuration with Lombok support
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        settings = {
          java = {
            configuration = {
              -- Enable annotation processing
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = vim.fn.expand("$JAVA_HOME"),
                },
              },
            },
            -- Enable Lombok support
            jdt = {
              ls = {
                lombokSupport = {
                  enabled = true,
                },
              },
            },
            -- Enable annotation processing
            compile = {
              annotation = {
                processing = {
                  enabled = true,
                },
              },
            },
            -- Ignore Lombok-specific warnings
            warnings = {
              "unused",
              "deprecation",
            },
            -- Additional settings for better annotation handling
            settings = {
              java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = "fernflower" },
                completion = {
                  favoriteStaticMembers = {
                    "org.junit.Assert.*",
                    "org.junit.Assume.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.junit.jupiter.api.DynamicContainer.*",
                    "org.junit.jupiter.api.DynamicTest.*",
                    "org.mockito.Mockito.*",
                    "org.mockito.ArgumentMatchers.*",
                    "org.mockito.Answers.*"
                  },
                },
              },
            },
          },
        },
      })

      -- ESLint specific configuration
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        root_dir = lspconfig.util.root_pattern(
          '.eslintrc',
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json',
          'eslint.config.js' -- This is for flat config
        ),
      })
      -- Additional settings for specific servers if needed
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      local nvim_lsp = require("lspconfig")
      
      -- Define on_attach function
      local on_attach = function(client, bufnr)
        -- Add any special on_attach configurations here
      end
      
      nvim_lsp.denols.setup({
        on_attach = on_attach,
        root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
      })

      nvim_lsp.ts_ls.setup({
        on_attach = on_attach,
        root_dir = nvim_lsp.util.root_pattern("package.json"),
        single_file_support = false,
      })
      -- autoformat
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end
          if client.supports_method("textDocument/formatting") then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })

      -- Disable formatting for all Python LSPs (we'll use black through null-ls)
      local function disable_formatting(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      lspconfig.ruff.setup({
        capabilities = capabilities,
        settings = {
          -- Ruff settings
          ruff = {
            lint = {
              args = {
                "--line-length=79",
                "--select=E,W",  -- Enable error and warning rules
                "--ignore=E203", -- Ignore whitespace before ':' for black compatibility
              },
            },
          },
        },
        on_attach = disable_formatting,
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
        on_attach = disable_formatting,
      })
    end,
  },
}
