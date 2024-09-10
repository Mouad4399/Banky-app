from django.urls import path
from core import views,transfer,transactions
app_name ='core'


urlpatterns=[
    path('search-account/', transfer.search_account, name='search-acc'),
    path('amount-transfer-process/', transfer.amount_transfer_process, name='amount_transfer_process'),
    path('transactions/', transactions.get_transactions, name='transactions'),
]
