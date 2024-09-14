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

    

from django.utils.timezone import now, timedelta
from django.db.models import Sum
from django.http import JsonResponse
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def transactions_summary(request):
    # Calculate the date 6 interval ago from today
    interval_type=request.data.get('interval','days')
    
    def timeDelta(count):
        if (interval_type == 'days'):
            return timedelta(days=count)
        return timedelta(weeks=count)
    

    interval_ago = now() - timeDelta(7)
    
    # Filter transactions from the last 7 interval
    transactions = Transaction.objects.filter(Q(date__gte=interval_ago) & Q(sender=request.user)|Q(receiver=request.user))
    
    # Initialize a list to hold the data
    interval_data = []

    # Loop through the past 6 interval
    for interval in range(7):
        start_interval = now() - timeDelta(interval + 1)
        end_interval = now() - timeDelta(interval)
        
        # Get outcome (sent transactions) and income (received transactions)
        income = transactions.filter(
            transaction_type="transfer", 
            receiver=request.user,
            date__range=[start_interval, end_interval]
        ).aggregate(Sum('amount'))['amount__sum'] or 0
        
        outcome = transactions.filter(
            transaction_type="transfer", 
            sender=request.user,
            date__range=[start_interval, end_interval]
        ).aggregate(Sum('amount'))['amount__sum'] or 0

        interval_data.append({
            "interval": end_interval.strftime("%Y-%m-%d"),
            "income": income,
            "outcome": outcome
        })
    
    # Reverse the data to go from oldest interval to most recent
    interval_data.reverse()

    return JsonResponse({"interval_transactions": interval_data}, safe=False)
    