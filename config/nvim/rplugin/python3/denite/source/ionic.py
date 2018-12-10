from .base import Base
from requests import get
from denite.util import globruntime
import json


class Source(Base):
    """
    Search through ionic's
    docs using Denite
    """

    def __init__(self, vim):
        super().__init__(vim)
        self.vim = vim
        self.name = 'ionic'
        self.kind = 'command'
        self.docs = []

    def on_init(self, context):
        """
        Get some inital data on startup
        """
        query = get('https://ionicframework.com/docs/v2/data/index.json')
        result = json.loads(query.text)
        res = result['ref']
        for val in res.values():
            self.docs.append({
                'word': val['t'],
                'action__command': '! open https://ionicframework.com/docs/v2' + val['p']
            })

    def gather_candidates(self, context):
        return sorted(self.docs, key=lambda value: value['word'])
