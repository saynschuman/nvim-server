-- import packer safely

local status, packer = pcall(require, "packer")
if not status then
  return
end


-- add list of plugins to install
return packer.startup(function(use)
  use("bluz71/vim-nightfly-guicolors") -- colorscheme
  use("nvim-tree/nvim-tree.lua")

end)
