from django.shortcuts import render
from django.views import generic

from dashboard.apps.core.utils import log


class IndexView(generic.ListView):
    """
    IndexView:
    """
    module = 'indexView'
    template_name = 'frontend/index.html'

    data = [
        ['#', 'Header', 'Header', 'Header', 'Header'],
        ['1,001', 'Lorem', 'ipsum', 'dolor', 'sit'],
        ['1,002', 'amet', 'consectetur', 'adipiscing', 'elit'],
        ['1,003', 'Integer', 'nec', 'odio', 'Praesent'],
        ['1,003', 'libero', 'Sed', 'cursus', 'ante'],
        ['1,004', 'dapibus', 'diam', 'Sed', 'nisi'],
        ['1,005', 'Nulla', 'quis', 'sem', 'at'],
        ['1,006', 'nibh', 'elementum', 'imperdit', 'Duis'],
        ['1,007', 'sagittis', 'ipsum', 'Praesent', 'mauris'],
        ['1,008', 'Fusce', 'nec', 'tellus', 'sed'],
        ['1,009', 'augue', 'semper', 'porta', 'Mauris'],
        ['1,010', 'massa', 'Vestibulum', 'lacinia', 'arcu'],
        ['1,011', 'eget', 'nulla', 'Class', 'aptent'],
        ['1,012', 'taciti', 'sociosqu', 'ad', 'litora'],
        ['1,013', 'torquent', 'per', 'conubia', 'nostra'],
        ['1,014', 'per', 'inceptos', 'himenaeos', 'Curabtur'],
        ['1,015', 'sodales', 'ligula', 'in', 'libero'],
    ]

    def get_queryset(self):
        log(self.module, 'get_queryset', file=__file__)

        return self.data

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['data'] = self.data

        log(self.module, 'get_queryset', 'data = %r' %
            self.data, file=__file__)

        return context
