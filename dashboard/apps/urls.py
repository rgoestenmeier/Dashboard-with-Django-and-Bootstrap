from django.urls import path
from django.urls.conf import include

from dashboard.apps.frontend.views import IndexView

app_name = 'app'

urlpatterns = [
    path('', 				IndexView.as_view(),						name='index'),

    path('pages/',			include('dashboard.apps.pages.urls')),
    path('components/',		include('dashboard.apps.components.urls')),
    path('utilities/',		include('dashboard.apps.utilities.urls')),
]
