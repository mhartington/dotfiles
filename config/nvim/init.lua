--  __  __ _ _               _       _ _     _
-- |  \/  (_) |             (_)     (_) |   | |
-- | \  / |_| | _____  ___   _ _ __  _| |_  | |_   _  __ _
-- | |\/| | | |/ / _ \/ __| | | '_ \| | __| | | | | |/ _` |
-- | |  | | |   <  __/\__ \ | | | | | | |_ _| | |_| | (_| |
-- |_|  |_|_|_|\_\___||___/ |_|_| |_|_|\__(_)_|\__,_|\__,_|
-- Author: Mike Hartington
-- repo  : https://github.com/mhartington/dotfiles/

vim.g.mapleader = ","
vim.o.tgc = true
vim.o.guifont = "VictorMono Nerd Font Mono:h20"
-- vim.opt.linespace = 1.2
require "mh.plugins"
vim.cmd("colorscheme OceanicNext")
require "mh.options"
require "mh.mappings"
require "mh.commands"
require "mh.completion"
require "mh.colors"

require "mh.autocmds"
require "mh.folds"
require "mh.filetree"
require "mh.statusline"
require "mh.treesitter"
require "mh.formatting"
require "mh.lsp"

