from django.shortcuts import render

from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from django.db.models import Q
from account.models import Account,KYC
from .serializers import KYCSearchSerializer
from .models import Transaction
from decimal import Decimal
# Create your views here.
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def search_account(request):
    if request.method == 'GET':
        query = request.data.get("account_id_or_number", None)  # Use request.GET for query in GET requests

        if not query:
            return Response({'error': 'Please provide account_id_or_number.'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            account = Account.objects.filter(
                Q(account_number=query) | Q(account_id=query)  # Use id for account_id
            ).distinct()

            if not account.exists():
                return Response({'detail': 'Account record not found.'}, status=status.HTTP_404_NOT_FOUND)

            # Assuming a one-to-one relationship between KYC and Account
            kyc = KYC.objects.get(account=account.first())  # Get the first account match

        except Account.DoesNotExist:
            return Response({'detail': 'Account record not found.'}, status=status.HTTP_404_NOT_FOUND)

        serializer = KYCSearchSerializer(kyc)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def amount_transfer_process(request):

    if request.method == "POST":
        # receiver information
        receiver_account = Account.objects.get(account_number=request.data.get('account_number'))
        receiver = receiver_account.user 
        # sender information
        sender = request.user 
        sender_account = request.user.account 
        
        pin_number= request.data.get('pin_number')
        amount = request.data.get("amount")
        amount=Decimal(amount)
        description = request.data.get("description")
        
        if not (sender_account.account_balance >=amount) :
            return Response({'detail':'unsufficient amount'}, status=status.HTTP_400_BAD_REQUEST)
        if not (pin_number == sender_account.pin_number):
            return Response({'detail':"Incorrect Pin."}, status=status.HTTP_400_BAD_REQUEST)
        
        new_transaction = Transaction.objects.create(
            user=request.user,
            amount=amount,
            description=description,
            receiver=receiver,
            sender=sender,
            sender_account=sender_account,
            receiver_account=receiver_account,
            status="processing",
            transaction_type="transfer"
        )
        new_transaction.save()
        

        new_transaction.status = "completed"
        new_transaction.save()

        # Remove the amount from the sender
        sender_account.account_balance -= new_transaction.amount
        sender_account.save()

        # Add the amount to the receiver
        receiver_account.account_balance += new_transaction.amount
        receiver_account.save()
        
        # Create Notification Object
        # Notification.objects.create(
        #     amount=new_transaction.amount,
        #     user=account.user,
        #     notification_type="Credit Alert"
        # )
        
        # Notification.objects.create(
        #     user=sender,
        #     notification_type="Debit Alert",
        #     amount=new_transaction.amount
        # )

        return Response({'transaction_id':new_transaction.transaction_id}, status=status.HTTP_200_OK)


    else:
        return Response({'detail':'errour occured ,Try again '},status=status.HTTP_400_BAD_REQUEST)





@api_view(['POST'])
@permission_classes([IsAuthenticated])
def amount_request_process(request):

    if request.method == "POST":
        # receiver information
        receiver_account = Account.objects.get(account_number=request.data.get('account_number'))
        receiver = receiver_account.user 
        # sender information
        sender = request.user 
        sender_account = request.user.account 
        
        pin_number= request.data.get('pin_number')
        amount = request.data.get("amount")
        amount=Decimal(amount)
        description = request.data.get("description")
        
        if not (pin_number == sender_account.pin_number):
            return Response({'detail':"Incorrect Pin."}, status=status.HTTP_400_BAD_REQUEST)
        
        new_transaction = Transaction.objects.create(
            user=request.user,
            amount=amount,
            description=description,
            receiver=receiver,
            sender=sender,
            sender_account=sender_account,
            receiver_account=receiver_account,
            status="processing",
            transaction_type="request"
        )
        new_transaction.save()
        

        new_transaction.status = "request_sent"
        new_transaction.save()
        
        # Create Notification Object
        # Notification.objects.create(
        #     amount=new_transaction.amount,
        #     user=account.user,
        #     notification_type="Credit Alert"
        # )
        
        # Notification.objects.create(
        #     user=sender,
        #     notification_type="Debit Alert",
        #     amount=new_transaction.amount
        # )

        return Response({'transaction_id':new_transaction.transaction_id}, status=status.HTTP_200_OK)


    else:
        return Response({'detail':'errour occured ,Try again '},status=status.HTTP_400_BAD_REQUEST)


from django.utils.timezone import now
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def settlement(request):
    transaction = Transaction.objects.get(transaction_id=request.data.get('transaction_id'))
    
    # the person that sent the transaction settlement
    account = Account.objects.get(account_id=transaction.sender_account.account_id)
    # account = Account.objects.get(pk=transaction.sender_account)

    if request.method == "POST":
        pin_number = request.data.get("pin_number")
        if pin_number != request.user.account.pin_number:
            return
        
        if not (request.user.account.account_balance <= 0 or request.user.account.account_balance < transaction.amount):
            request.user.account.account_balance -= transaction.amount
            request.user.account.save()

            account.account_balance += transaction.amount
            account.save()

            transaction.status = "request_settled"
            transaction.updated=now()
            transaction.save()
            
            return Response({'transaction_id':transaction.transaction_id}, status=status.HTTP_200_OK)
    else:
        return Response({'detail':'errour occured ,Try again '},status=status.HTTP_400_BAD_REQUEST)



# def deletepaymentrequest(request, account_number ,transaction_id):
#     account = Account.objects.get(account_number=account_number)
#     transaction = Transaction.objects.get(transaction_id=transaction_id)

#     if request.user == transaction.user:
#         transaction.delete()
#         messages.success(request, "Payment Request Deleted Sucessfully")
#         return 