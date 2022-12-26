local nocode = function()
  return vim.fn.exists('g:vscode') == 0
end

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')
packer.init({ compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua' })

--return require('packer').startup(function(use)
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  --if packer_bootstrap then
    --require('packer').sync()
  --end
--end)

local use = require('packer').use

use 'wbthomason/packer.nvim'

use 'shaunsingh/nord.nvim'

use 'nvim-tree/nvim-web-devicons'
use {
    'nvim-tree/nvim-tree.lua',
    config = { nocode }
}
use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}

use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  requires = { {'nvim-lua/plenary.nvim'} }
}

if not vim.g.vscode then
    require('packer_compiled')
end


