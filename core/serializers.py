from rest_framework import serializers
from userauths.models import User
from account.models import KYC,Account

class KYCSearchSerializer(serializers.ModelSerializer):
    email = serializers.CharField(source='user.email', read_only=True)
    account_number = serializers.CharField(source='account.account_number', read_only=True)  # Assuming account_number exists
    account_id = serializers.UUIDField(source='account.account_id', read_only=True)  # Assuming account_id exists

    class Meta:
        model = KYC
        fields = ['full_name', 'email', 'account_number', 'account_id']
    