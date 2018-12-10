#! /usr/bin/env python3
# ============================================================================
# FILE: devicons.py
# AUTHOR: Mike Hartington <mhartington at gmail.com>
# License: MIT license
# ============================================================================

import typing
from defx.base.column import Base
from defx.context import Context
from neovim import Nvim
class Column(Base):

    def __init__(self, vim: Nvim) -> None:
        super().__init__(vim)
        self.vim = vim
        self.name = 'devicons'
        self.column_length = 3
        self.before_padding = self.vim.vars['WebDevIconsNerdTreeBeforeGlyphPadding']
        self.after_padding = self.vim.vars['WebDevIconsNerdTreeAfterGlyphPadding']

    def get(self, context: Context, candidate: dict) -> str:
        filename =  candidate['word']
        icon = self.vim.call('WebDevIconsGetFileTypeSymbol', filename, candidate['is_directory'])
        if 'is_root' in candidate:
            return '{0}{1}'.format(self.before_padding, self.after_padding)
        return '{0}{1}{2}'.format(self.before_padding, icon, self.after_padding)


    def length(self, context: Context) -> int:
        return self.column_length


