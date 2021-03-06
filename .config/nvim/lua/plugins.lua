local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
    auto_reload_compiled = true,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself

	-- nvimlsp plugins
	use("williamboman/nvim-lsp-installer")
	use("neovim/nvim-lspconfig") -- Collection of configurations for the built-in LSP client
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	--  autocomplete plugins
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")
	use("onsails/lspkind-nvim")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	-- use "github/copilot.vim"
	use({
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require('plugins.copilot')
			end, 100)
		end,
	})
	use({
		"zbirenbaum/copilot-cmp",
		module = "copilot_cmp",
	})

	-- treesitter plugins
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-refactor")
	use("windwp/nvim-ts-autotag")
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- telescope plugins
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-vimspector.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("tami5/sqlite.lua")
	use("nvim-telescope/telescope-frecency.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")

	-- statusline plugins
	use("nvim-lualine/lualine.nvim")

	-- debug plugins
	use "puremourning/vimspector"
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- UI
	use("rcarriga/nvim-notify")
	use("lukas-reineke/indent-blankline.nvim")
	use("kyazdani42/nvim-web-devicons")
	-- use("norcalli/nvim-colorizer.lua")
    use("NvChad/nvim-colorizer.lua")
	use("Mofiqul/vscode.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
        run = "CatppuccinCompile",
	})
    use("projekt0n/github-nvim-theme")
	use("goolord/alpha-nvim")
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

	-- Utilities
	use("windwp/nvim-autopairs")
	use("lewis6991/gitsigns.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("numToStr/Comment.nvim")
	use("luukvbaal/stabilize.nvim")
	-- use "ggandor/lightspeed.nvim"
	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").set_default_keymaps()
		end,
	})
	use("Shatur/neovim-session-manager")
	use("ahmedkhalf/project.nvim")
	use("aserowy/tmux.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
