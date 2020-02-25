from django.urls import path

import dashboard.apps.pages.blank.views as BlankViews
import dashboard.apps.pages.login.views as LoginViews
import dashboard.apps.pages.pagenotfound.views as PageNotFoundViews
import dashboard.apps.pages.password.views as PasswordViews
import dashboard.apps.pages.register.views as RegisterViews
import dashboard.apps.pages.charts.views as ChartsViews
import dashboard.apps.pages.tables.views as TablesViews

app_name = 'pages'

urlpatterns = [
    path('', 				ChartsViews.IndexView.as_view(),			name='index'),
    path('blank', 			BlankViews.IndexView.as_view(),				name='blank'),
    path('charts', 			ChartsViews.IndexView.as_view(),			name='charts'),
    path('login', 			LoginViews.IndexView.as_view(), 			name='login'),
    path('pagenotfound', 	PageNotFoundViews.IndexView.as_view(),		name='pagenotfound'),
    path('password', 		PasswordViews.IndexView.as_view(),			name='password'),
    path('register', 		RegisterViews.IndexView.as_view(),			name='register'),
    path('tables', 			TablesViews.IndexView.as_view(),			name='tables'),
]
