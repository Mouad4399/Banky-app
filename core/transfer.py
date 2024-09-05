from django.shortcuts import render

from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from django.db.models import Q
from account.models import Account,KYC
from .serializers import KYCSearchSerializer
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
       