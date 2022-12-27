local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  autocmd!
  autocmd BufWritePost plugin-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely

local status, packer = pcall(require, "packer")
if not status then
  return
end

-- nvim-tree plugin
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup()

-- add list of plugins to install
return packer.startup(function(use)

  use("wbthomason/packer.nvim")
  use("bluz71/vim-nightfly-guicolors") -- colorscheme
  use("szw/vim-maximizer")
  use {
  'nvim-tree/nvim-tree.lua',
   requires = {
     'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use("tpope/vim-fugitive")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

