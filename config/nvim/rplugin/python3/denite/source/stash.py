from subprocess import run, PIPE
from itertools import filterfalse
from tempfile import NamedTemporaryFile


from .base import Base as BaseSource
from ..kind.base import Base as BaseKind
from denite import util


def runProcess(args):
    output = run(args, stdout=PIPE)
    if output.returncode is not 0:
        return []
    return output.stdout.decode('utf-8')


class Source(BaseSource):

    def __init__(self, vim):
        super().__init__(vim)
        self.vim = vim
        self.name = 'stash'
        self.kind = Kind(vim)

    def on_init(self, context):
        output = runProcess(['git', 'stash', 'list'])
        context['stashOutput'] = list(filter(None, output.split('\n')))

    def parseItems(self, stashData):
        return list(map(lambda stash: {
            'word': stash,
            'stash_ref': stash.split(':')[0]
        }, stashData))

    def gather_candidates(self, context):
        if context['stashOutput']:
            stashList = self.parseItems(context['stashOutput'])
            return list(map(lambda symbol: {
                'word': symbol['word'],
                'stash_ref': symbol['stash_ref'],
            }, stashList))
        return []


class Kind(BaseKind):
    def __init__(self, vim):
        super().__init__(vim)
        self.vim = vim
        self.persist_actions += ['preview', 'highlight']
        self._previewed_target = {}
        self._previewed_buffers = {}
        self.name = 'gitstash'

    def action_pop(self, context):
        target = context['targets'][0]
        confirm = util.input(self.vim, context, 'Pop stash {}? [y/n]: '.format(target['stash_ref']), 'n') == 'y'
        if confirm:
            runProcess(['git', 'stash', 'pop', target['stash_ref']])
        else:
            self.vim.out_write('{} \n'.format(confirm))

    def action_drop(self, context):
        target = context['targets'][0]
        confirm = util.input(self.vim, context, 'Drop stash {}? [y/n]: '.format(target['stash_ref']), 'n') == 'y'
        if confirm:
            runProcess(['git', 'stash', 'drop', target['stash_ref']])
        else:
            self.vim.out_write('{} \n'.format(confirm))

    def action_apply(self, context):
        target = context['targets'][0]
        confirm = util.input(self.vim, context, 'Apply stash {}? [y/n]: '.format(target['stash_ref']), 'n') == 'y'
        if confirm:
            runProcess(['git', 'stash', 'apply', target['stash_ref']])
        else:
            self.vim.out_write('{} \n'.format(confirm))

    def action_preview(self, context):
        target = context['targets'][0]

        if (not context['auto_preview'] and
                self._get_preview_window() and
                self._previewed_target == target):
            self.vim.command('pclose!')
            return

        # We're doing preview, let's get the data
        # git stash show -p stash@{1}
        tmpfile = NamedTemporaryFile(delete=False)
        currentStash = run(['git', 'stash', 'show', '-p', target['stash_ref']], stdout=tmpfile)

        listed = self.vim.call('buflisted', target['stash_ref'])
        path = self.vim.call('bufname', target['stash_ref'])
        prev_id = self.vim.call('win_getid')

        self.vim.call('denite#helper#preview_file', context, tmpfile.name)
        self.vim.command('wincmd P')

        if not listed:
            self._previewed_buffers[target['stash_ref']] = self.vim.call('bufnr', '%')


        self.vim.call('win_gotoid', prev_id)
        self._previewed_target = target

        self._cleanup()


    def _get_preview_window(self):
        return next(filterfalse(lambda x: not x.options['previewwindow'], self.vim.windows), None)

    def _cleanup(self):
        for bufnr in self._previewed_buffers.values():
            if not self.vim.call('win_findbuf', bufnr) and self.vim.call('buflisted', bufnr):
                self.vim.command('silent bdelete ' + str(bufnr))
