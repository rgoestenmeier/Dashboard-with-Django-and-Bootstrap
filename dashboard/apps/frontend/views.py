from django.shortcuts import render
from django.views import generic


class IndexView(generic.TemplateView):
    """
    IndexView:
    """
    module = 'indexView'
    template_name = 'frontend/index.html'
