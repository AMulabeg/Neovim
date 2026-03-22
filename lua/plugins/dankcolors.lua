return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#101418',
				base01 = '#101418',
				base02 = '#8d979f',
				base03 = '#8d979f',
				base04 = '#e8f4ff',
				base05 = '#f5faff',
				base06 = '#f5faff',
				base07 = '#f5faff',
				base08 = '#ff739e',
				base09 = '#ff739e',
				base0A = '#60b8ff',
				base0B = '#7cff8d',
				base0C = '#abd9ff',
				base0D = '#60b8ff',
				base0E = '#7cc4ff',
				base0F = '#7cc4ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#8d979f',
				fg = '#f5faff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#60b8ff',
				fg = '#101418',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8d979f' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#abd9ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#7cc4ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#60b8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#60b8ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#abd9ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#7cff8d',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#e8f4ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#e8f4ff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#8d979f',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
