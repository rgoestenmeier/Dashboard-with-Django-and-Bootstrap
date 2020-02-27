from django.shortcuts import render
from django.views import generic

from dashboard.apps.core.utils import log


class IndexView(generic.ListView):
    """
    IndexView:
    """
    module = 'IndexView'
    template_name = 'others/base.html'

    data = [
        ['#', 'Header', 'Header', 'Header', 'Header'],
        ['1,001', 'Lorem', 'ipsum', 'dolor', 'sit'],
    ]

    def get_queryset(self):
        log(self.module, 'get_queryset', file=__file__)

        return self.data

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['data'] = self.data

        return context
