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

    projects_original = [
        ['Server Migration', '20%', 'bg-danger', '20'],
        ['Sales Tracking', '40%', 'bg-warning', '40'],
        ['Customer Database', '60%', '', '60'],
        ['Payout Details', '80%', 'bg-info', '80'],
        ['Account Setup', 'Complete!', 'bg-success', '100']
    ]

    projects = [
        ['Server Migration', '10%', 'bg-danger', '20'],
        ['Sales Tracking', '70%', 'bg-info', '40'],
        ['Customer Database', '60%', '', '60'],
        ['Payout Details', 'Complete!', 'bg-success', '100'],
        ['Account Setup', '40%', 'bg-warning', '40']
    ]

    earnings_monthly = '$40.000'
    earnings_annual = '$215.000'
    task_percent = '75%'
    pending_requests = 18

    def get_queryset(self):
        log(self.module, 'get_queryset', file=__file__)

        return self.data

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['data'] = self.data

        context['earnings_monthly'] = self.earnings_monthly
        context['earnings_annual'] = self.earnings_annual
        context['task_percent'] = self.task_percent
        context['pending_requests'] = self.pending_requests
        context['projects'] = self.projects

        # log(self.module, 'get_context_data', 'context=%r' % context, file = __file__)

        return context
