from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'neomake'
        self.kind = 'file'

    def on_init(self, context):
        context['__bufnr'] = str(self.vim.call('bufnr', '%'))

    def gather_candidates(self, context):
        loclist = self.vim.call('getloclist', context['__bufnr'])
        return [self._convert(loc) for loc in loclist]

    def _convert(self, locinfo):
        return {
            'word': locinfo['text'],
            'abbr': '%d:%d %s' % (locinfo['lnum'], locinfo['col'], locinfo['text']),
            'action__path': self.vim.call('bufname', locinfo['bufnr']),
            'action__line': locinfo['lnum'],
            'action__col': locinfo['col']
        }
