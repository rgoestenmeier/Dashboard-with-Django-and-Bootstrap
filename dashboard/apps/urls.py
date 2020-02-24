from django.contrib import admin
from django.urls import path

import dashboard.apps.frontend.views as views

import dashboard.apps.components.buttons.views as ButtonsViews
import dashboard.apps.components.cards.views as CardsViews


import dashboard.apps.utilities.colors.views as ColorsViews
import dashboard.apps.utilities.borders.views as BordersViews
import dashboard.apps.utilities.animations.views as AnimationsViews
import dashboard.apps.utilities.others.views as OthersViews


import dashboard.apps.pages.blank.views as BlankViews
import dashboard.apps.pages.login.views as LoginViews
import dashboard.apps.pages.pagenotfound.views as PageNotFoundViews
import dashboard.apps.pages.password.views as PasswordViews
import dashboard.apps.pages.register.views as RegisterViews

import dashboard.apps.pages.charts.views as ChartsViews
import dashboard.apps.pages.tables.views as TablesViews

app_name = 'dashboard'

urlpatterns = [
    path('', 				views.IndexView.as_view(),				name='index'),

    path('blank', 			BlankViews.IndexView.as_view(),			name='blank'),
    path('charts', 			ChartsViews.IndexView.as_view(),		name='charts'),
    path('login', 			LoginViews.IndexView.as_view(), 		name='login'),
    path('pagenotfound', 	PageNotFoundViews.IndexView.as_view(),	name='pagenotfound'),
    path('password', 		PasswordViews.IndexView.as_view(),		name='password'),
    path('register', 		RegisterViews.IndexView.as_view(),		name='register'),
    path('tables', 			TablesViews.IndexView.as_view(),		name='tables'),
    path('buttons', 		ButtonsViews.IndexView.as_view(),		name='buttons'),
    path('cards', 			CardsViews.IndexView.as_view(),			name='cards'),

    path('animations', 		AnimationsViews.IndexView.as_view(),	name='animations'),
    path('borders',			BordersViews.IndexView.as_view(), 		name='borders'),
    path('colors',			ColorsViews.IndexView.as_view(), 		name='colors'),
    path('others',			OthersViews.IndexView.as_view(), 		name='others'),
]
