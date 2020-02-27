from django.contrib import admin

from django.urls import path
from django.urls.conf import include

app_name = 'main'

urlpatterns = [
    path('', 		include('dashboard.apps.urls')),
    path('admin/',	admin.site.urls),
]
