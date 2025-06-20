return {
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "echasnovski/mini.icons", version = false },
			{
				"L3MON4D3/LuaSnip",
			},
			{
				"folke/lazydev.nvim",
			},
		},
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "  ",
					Method = "  ",
					Function = "  ",
					Constructor = "  ",
					Field = "  ",
					Variable = "  ",
					Class = "  ",
					Interface = "  ",
					Module = "  ",
					Property = "  ",
					Unit = "  ",
					Value = "  ",
					Enum = "  ",
					Keyword = "  ",
					Snippet = "  ",
					Color = "  ",
					File = "  ",
					Reference = "  ",
					Folder = "  ",
					EnumMember = "  ",
					Constant = "  ",
					Struct = "  ",
					Event = "  ",
					Operator = "  ",
					TypeParameter = "  ",
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			completion = {
				accept = {
					create_undo_point = true,
					auto_brackets = {
						enabled = true,
					},
				},
				list = {
					selection = { preselect = true, auto_insert = false },
				},
				menu = {
					enabled = true,
					max_height = 20,
					border = "single",
					winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
					draw = {
						columns = {
							{
								"kind_icon",
								"label",
								gap = 1,
							},
							{
								"label_description",
								"kind",
								gap = 2,
							},
							{
								"source_name",
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					update_delay_ms = 50,
					treesitter_highlighting = true,
					window = {
						border = "single",
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
					},
				},
				ghost_text = {
					enabled = false,
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "single",
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
