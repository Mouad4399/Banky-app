from django.urls import path
from core import views,transfer
app_name ='core'


urlpatterns=[
    path('search-account/', transfer.search_account, name='search-acc'),
]
