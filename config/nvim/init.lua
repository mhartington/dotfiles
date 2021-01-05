--  __  __ _ _               _       _ _     _
-- |  \/  (_) |             (_)     (_) |   | |
-- | \  / |_| | _____  ___   _ _ __  _| |_  | |_   _  __ _
-- | |\/| | | |/ / _ \/ __| | | '_ \| | __| | | | | |/ _` |
-- | |  | | |   <  __/\__ \ | | | | | | |_ _| | |_| | (_| |
-- |_|  |_|_|_|\_\___||___/ |_|_| |_|_|\__(_)_|\__,_|\__,_|
-- Author: Mike Hartington
-- repo  : https://github.com/mhartington/dotfiles/

vim.cmd("filetype plugin indent on")
require "mh.plugins"
require "mh.options"
require "mh.mappings"
require "mh.commands"
require "mh.colors"

require "mh.autocmds"
require "mh.folds"
require "mh.filetree"
require "mh.statusline"
require "mh.treesitter"
require "mh.formatting"
require "mh.lsp"
