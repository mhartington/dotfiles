from os import path

from denite.source.base import Base
from denite.util import globruntime
from ..kind.command import Kind as Command
from itertools import filterfalse

class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'color'
        self.kind = Kind(vim)
        self.vim = vim

    def on_init(self, context):
        context['currentColor'] = self.vim.vars['colors_name']


    def on_close(self, context):
        self.vim.out_write('nothing picked\n')
        self.vim.command('silent colorscheme {}'.format(context['currentColor']))

    def gather_candidates(self, context):
        colorschemes = {}

        for filename in globruntime(context['runtimepath'], 'colors/*.vim'):
            colorscheme = path.splitext(path.basename(filename))[0]
            colorschemes[colorscheme] = {
                'word': colorscheme,
                'action__command': 'colorscheme ' + colorscheme
            }

        return sorted(colorschemes.values(), key=lambda value: value['word'])


class Kind(Command):
    def __init__(self, vim):
        super().__init__(vim)
        self.vim = vim
        self.name = 'color'

    def action_preview(self, context):
        target = context['targets'][0]
        self.vim.command('silent colorscheme {}'.format(target['word']))

