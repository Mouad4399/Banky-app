from django.shortcuts import render

from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from django.db.models import Q
from account.models import Account,KYC
from .serializers import KYCSearchSerializer,SentTransactionSerializer,ReceivedTransactionSerializer,AllTransactionSerializer
from .models import Transaction
from decimal import Decimal


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_transactions(request):
    transaction_type=request.data.get('type')
    if transaction_type =='all':
        records = Transaction.objects.filter(Q(sender=request.user)|Q(receiver=request.user)).order_by("-date").distinct()
        serializer = AllTransactionSerializer(records,many=True,context={'user':request.user})
        return Response(serializer.data,status=status.HTTP_200_OK)
    elif transaction_type== "sent":
        records = Transaction.objects.filter(sender=request.user).order_by("-date").distinct()
        serializer = SentTransactionSerializer(records,many=True,context={'type':transaction_type})
        return Response(serializer.data,status=status.HTTP_200_OK)
    elif transaction_type=='received':
        records = Transaction.objects.filter(receiver=request.user).order_by("-date").distinct()
        serializer = ReceivedTransactionSerializer(records,many=True,context={'type':transaction_type})
        return Response(serializer.data,status=status.HTTP_200_OK)
        
    # elif transaction_type == 'sent_request':

        
    # elif transaction_type == 'received_request':
    
    return Response({},status=status.HTTP_404_NOT_FOUND)

    
    
    