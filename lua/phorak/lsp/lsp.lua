return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'saadparwaiz1/cmp_luasnip',
			'stevearc/conform.nvim'
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				update_in_insert = true,
			})
			local cmp = require 'cmp'
			local cmp_lsp = require 'cmp_nvim_lsp'
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities())


			require("mason").setup()
			require("mason-lspconfig").setup {
				ensure_installed = { "lua_ls", "rust_analyzer" },
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup {
							capabilities = capabilities
						}
					end,
					["rust_analyzer"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.rust_analyzer.setup {
							settings = {
								['rust-analyzer'] = {
									check = {
										command = "clippy"
									},
									diagnostics = {
										enable = true,
									}
								}
							},
							capabilities = capabilities,
						}
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup {
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" }
									},
									telemetry = { enable = false },
								}
							}
						}
					end,
				}
			}
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup {
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},

				mapping = cmp.mapping.preset.insert({
					['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
					['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
					['<CR>'] = cmp.mapping.confirm({ select = false }),
					['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
					-- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
					["<C-f>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' }, -- For luasnip users.
				}, {
					{ name = 'buffer' },
				})
			}

			require("conform").setup {
				formatters_by_ft = {
					lua = { "stylua" },
				},
			}
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format {
						bufnr = args.buf,
						lsp_fallback = true,
						quiet = true,
					}
				end,
			})
		end,
	},
}
