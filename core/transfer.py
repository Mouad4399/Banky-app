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
        reciever_account = Account.objects.get(account_number=request.data.get('account_number'))
        reciever = reciever_account.user 
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
            reciever=reciever,
            sender=sender,
            sender_account=sender_account,
            reciever_account=reciever_account,
            status="processing",
            transaction_type="transfer"
        )
        new_transaction.save()
        

        new_transaction.status = "completed"
        new_transaction.save()

        # Remove the amount from the sender
        sender_account.account_balance -= new_transaction.amount
        sender_account.save()

        # Add the amount to the reciever
        reciever_account.account_balance += new_transaction.amount
        reciever_account.save()
        
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

        return Response({'detail':'Successful'}, status=status.HTTP_200_OK)


    else:
        return Response({'detail':'errour occured ,Try again '},status=status.HTTP_400_BAD_REQUEST)
