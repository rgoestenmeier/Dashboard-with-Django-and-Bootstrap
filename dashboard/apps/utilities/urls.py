from django.urls import path

import dashboard.apps.utilities.colors.views as ColorsViews
import dashboard.apps.utilities.borders.views as BordersViews
import dashboard.apps.utilities.animations.views as AnimationsViews
import dashboard.apps.utilities.others.views as OthersViews

app_name = 'utilities'

urlpatterns = [
    path('',				BordersViews.IndexView.as_view(), 		name='index'),
    path('animations/', 	AnimationsViews.IndexView.as_view(),	name='animations'),
    path('borders/',		BordersViews.IndexView.as_view(), 		name='borders'),
    path('colors/',			ColorsViews.IndexView.as_view(), 		name='colors'),
    path('others/',			OthersViews.IndexView.as_view(), 		name='others'),
]
