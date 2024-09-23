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
        records = Transaction.objects.filter(sender=request.user,transaction_type='transfer').order_by("-date").distinct()
        serializer = SentTransactionSerializer(records,many=True,context={'type':transaction_type})
        return Response(serializer.data,status=status.HTTP_200_OK)
    elif transaction_type=='received':
        records = Transaction.objects.filter(receiver=request.user,transaction_type='transfer').order_by("-date").distinct()
        serializer = ReceivedTransactionSerializer(records,many=True,context={'type':transaction_type})
        return Response(serializer.data,status=status.HTTP_200_OK)
        
    elif transaction_type == 'sent_requests':
        records = Transaction.objects.filter(sender=request.user,transaction_type='request').order_by("-date").distinct()
        serializer = SentTransactionSerializer(records,many=True,context={'type':transaction_type})
        return Response(serializer.data,status=status.HTTP_200_OK)
        
    elif transaction_type == 'received_requests':
        records = Transaction.objects.filter(receiver=request.user,transaction_type='request').order_by("-date").distinct()
        serializer = ReceivedTransactionSerializer(records,many=True,context={'type':transaction_type})
        return Response(serializer.data,status=status.HTTP_200_OK)
    
    return Response({},status=status.HTTP_404_NOT_FOUND)

    

from django.utils.timezone import now, timedelta
from django.db.models import Sum
from django.http import JsonResponse

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def transactions_summary(request):
    # Get the interval type ('days' or 'weeks')
    interval_type = request.data.get('interval', 'days')
    
    def get_interval_range(count):
        if interval_type == 'days':
            # Calculate the start and end of the day, setting the time to midnight (start of day)
            end_of_day = now().replace(hour=23, minute=59, second=59, microsecond=999) - timedelta(days=count)
            start_of_day = end_of_day - timedelta(days=1)
            return start_of_day, end_of_day
        else:
            # Calculate the start and end of the week, setting the time to the start of the week (e.g., Monday)
            end_of_week = now().replace(hour=23, minute=59, second=59, microsecond=999) - timedelta(weeks=count)
            start_of_week = end_of_week - timedelta(weeks=1)
            return start_of_week, end_of_week

    # Initialize a list to hold the interval data (7 days or 6 weeks)
    interval_data = []

    # Loop through the past 7 intervals
    for interval in range(7):
        start_interval, end_interval = get_interval_range(interval)
        
        # Filter transactions within the interval for the user
        transactions = Transaction.objects.filter(
            Q(sender=request.user) | Q(receiver=request.user),
            date__range=[start_interval, end_interval]
        )
        
        # Get outcome (sent transactions) and income (received transactions)
        income = transactions.filter(
            transaction_type="transfer", 
            receiver=request.user
        ).aggregate(Sum('amount'))['amount__sum'] or 0
        
        outcome = transactions.filter(
            transaction_type="transfer", 
            sender=request.user
        ).aggregate(Sum('amount'))['amount__sum'] or 0

        interval_data.append({
            "interval": end_interval.strftime("%Y-%m-%d"),
            "income": income,
            "outcome": outcome
        })
    
    # Reverse the data to show from oldest to most recent interval
    interval_data.reverse()

    return JsonResponse({"interval_transactions": interval_data}, safe=False)
