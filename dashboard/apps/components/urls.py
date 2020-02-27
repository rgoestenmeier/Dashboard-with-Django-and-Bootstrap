from django.urls import path

import dashboard.apps.components.buttons.views as ButtonsViews
import dashboard.apps.components.cards.views as CardsViews

app_name = 'components'

urlpatterns = [
    path('', 				ButtonsViews.IndexView.as_view(),		name='index'),
    path('buttons/', 		ButtonsViews.IndexView.as_view(),		name='buttons'),
    path('cards/', 			CardsViews.IndexView.as_view(),			name='cards'),
]
