-- 自动安装packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- 保存当前文件时自动执行PackerSync命令
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- packer - https://github.com/wbthomason/packer.nvim
-- awesome-neovim - https://github.com/rockerBOO/awesome-neovim
local ok, packer = pcall(require, "packer")
if not ok then
	return
end

-- 自定义初始化
packer.init({
	clone_timeout = 60 * 10, -- git clone超时，秒
})

return packer.startup(function(use)

	-- mixed
  use("wbthomason/packer.nvim") -- 管理packer自身
  use("fengwk/im-switch.nvim") -- 中英文切换
  use("voldikss/vim-translator") -- 翻译
  use("stevearc/stickybuf.nvim") -- 锁定buffer，避免误操作在非预期的位置打开窗口，比如在qf里打开了窗口
  use("fengwk/my-utils.nvim") -- 抽离所有通用工具方法

  -- themes
  -- use("ellisonleao/gruvbox.nvim")
  -- use("rebelot/kanagawa.nvim")
  use("Mofiqul/vscode.nvim")
  -- use("bluz71/vim-nightfly-colors")
  -- use("fengwk/my-darkplus.nvim")
  use("sainnhe/everforest")

  -- terminal
  use({ "akinsho/toggleterm.nvim", tag = "*" })

  -- git
  use("lewis6991/gitsigns.nvim")

  -- markdown
  -- use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", ft = "markdown" }) -- 在浏览器中预览Markdown
  -- use({ "md-img-paste-devs/md-img-paste.vim", ft = "markdown" }) -- 黏贴剪切板中的图片到Markdown

  -- workspaces
  use("natecraddock/workspaces.nvim") -- 简单的工作空间管理
  use("fengwk/workspaces-enhancer.nvim") -- workspaces.nvim功能增强set

	-- editor enhancer
	use("kylechui/nvim-surround") -- surround
	-- use("vim-scripts/ReplaceWithRegister") -- 使用gr进行替换，与LSP快捷键冲突，有替代方式先注释
	use("numToStr/Comment.nvim") -- 注释
	use("mg979/vim-visual-multi") -- 多光标，:h vm-*
  use({ "kevinhwang91/nvim-bqf", ft = "qf" }) -- quickfix增强
  use({ "phaazon/hop.nvim", branch = "v2" }) -- like easymotion
  use({ "fengwk/wildfire.vim", branch = "feat/skip-same-size-textobj" }) -- textobjects选择器
  use({ "windwp/nvim-autopairs", commit = "03580d758231956d33c8dd91e2be195106a79fa4" }) -- 自动补充成对符号
  use("godlygeek/tabular") -- 自定义对齐格式化
  use("jbyuki/venn.nvim") -- 绘制ASCII图

	-- ui enhancer
  use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- 状态栏增强
  use("NvChad/nvim-colorizer.lua") -- 颜色提示
  use("lukas-reineke/indent-blankline.nvim") -- 垂直缩进线

  -- nvim-treesitter | 提供代码的语法解析和高亮，比neovim原生的解析器更快且更加强大
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  -- nvim-treesitter-textobjects | 使用treesitter增强textobjets
  use("nvim-treesitter/nvim-treesitter-textobjects")

  use({ "neoclide/coc.nvim", branch = "release" })

	-- 这个命令需要在最后执行，它会在首次安装packer时自动进行配置安装
	if packer_bootstrap then
		require("packer").sync()
	end

end)
