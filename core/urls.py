from django.urls import path
from core import views,payment,transactions
app_name ='core'


urlpatterns=[
    path('search-account/', payment.search_account, name='search-acc'),
    path('amount-transfer-process/', payment.amount_transfer_process, name='amount_transfer_process'),
    path('amount-request-process/', payment.amount_request_process, name='amount_request_process'),
    path('settlement/', payment.settlement, name='settlement'),
    path('delete-payment-request/', payment.delete_payment_request, name='delete_payment_request'),
    path('transactions/', transactions.get_transactions, name='transactions'),
    # path('get-transaction-details/', transactions.get_transaction_details, name='get_transaction_details'),
    path('transactions_summary/', transactions.transactions_summary, name='transactions_summary'),
]
