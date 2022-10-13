-- some aliases
local cmd = vim.cmd
local fn = vim. fn
local g = vim.g
local opt = vim.opt
local wo = vim.wo
local keymap  = vim.keymap


-- packer bootstrap
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- cargar plugins con packer
require('packer').startup(function(use)
  --pluginzone
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons'

  --syntax highlightning
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  --theme
  use {
    'briones-gabriel/darcula-solid.nvim',
    requires = 'rktjmp/lush.nvim'
  }

  --LSP
  use {
    'neovim/nvim-lspconfig'
  }

  --para packer bootstrap
  if packer_bootstrap then
    require('packer').sync()
  end
end)

--configuración de plugins
--treesitter config
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {
    "c",
    "lua",
    "python",
    "javascript",
    "go",
    "typescript",
    "html",
    "css",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}

--theme config
cmd[[colorscheme darcula-solid]]


--lsp config


-- global options
wo.number = true                --números
wo.relativenumber = true        --números relativos
opt.autoread = true             --releer archivo si es cambiado desde afuera de vim
opt.encoding = 'utf-8'
opt.hidden = true               --enable background buffers
opt.incsearch = false           --no ir mostrando dónde acierta la búsqueda
opt.ignorecase = true           --ignore case on search
opt.inccommand = 'split'        --splitear cuando haga comandos
opt.scrolloff = 10              --mantener 10 líneas desde top/bottom
opt.sidescrolloff = 10          --mantener 10 columnas cuando te vas al límite por el costado
opt.cursorline = true           --línea en posición de cursor
opt.expandtab = true            --space instead of tab
opt.shiftwidth = 2              --indentación con >>/<<
opt.softtabstop = 2             --espacios por los que cuenta un tab
opt.smartindent = true          --pequeñas reglas que ayudan a la indentación
opt.wrap = false                --no hacer wrap de línea
opt.termguicolors = true        --más colores en terminal
opt.pumblend = 30               --opacidad de autocmp
opt.list = true                 --mostrar espacios y tabs
opt.clipboard:prepend { 'unnamed' , 'unnamedplus' } --compartir clipboard con sistema
opt.mouse = 'nv'                --mouse en modo normal y visual
opt.splitbelow = true           --nueva ventana horizontal por abajo
opt.splitright = true           --nueva ventana vertical por la derecha


--keymaps
g.mapleader = ' '                       --<space> as mapleader
keymap.set('n', 'x', '"_x')             --x sin yank
keymap.set('n', '<C-a>', 'gg<S-v>G')    --selectall
keymap.set('n', '<Leader>e', ':Ex<CR>') --<space>e abre netrw
keymap.set('n', '<bs>', ':nohlsearch<cr>', { silent = true }) --sacar hl con backspace

