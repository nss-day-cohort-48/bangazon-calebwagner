
from django.urls import path
from .views import user_favorite_list, incomplete_orders_list

urlpatterns = [
    path('reports/userfavorites', user_favorite_list),
    path('reports/incompleteorders', incomplete_orders_list),
]