from rest_framework import serializers
from userauths.models import User
from account.models import KYC,Account
from .models import Transaction

class KYCSearchSerializer(serializers.ModelSerializer):
    email = serializers.CharField(source='user.email', read_only=True)
    account_number = serializers.CharField(source='account.account_number', read_only=True)  # Assuming account_number exists
    account_id = serializers.UUIDField(source='account.account_id', read_only=True)  # Assuming account_id exists

    class Meta:
        model = KYC
        fields = ['full_name', 'email', 'account_number', 'account_id']
    

class AllTransactionSerializer(serializers.ModelSerializer):
    type = serializers.SerializerMethodField()
    full_name = serializers.SerializerMethodField()
    class Meta:
        model = Transaction
        fields = ['transaction_id','sender_account','receiver_account','full_name','amount','date','status','transaction_type','type']
        
    def get_full_name(self, obj):
        try:
            # we choose the other actor
            return KYC.objects.get(account=obj.receiver_account).full_name if obj.sender == self.context.get('user') else KYC.objects.get(account=obj.sender_account).full_name
        except KYC.DoesNotExist:
            return None

    def get_type(self,obj):
        try:
            if obj.transaction_type == 'transfer':
                return 'sent' if obj.sender == self.context.get('user') else 'received'
            else:
                return 'sent_request' if obj.sender == self.context.get('user') else 'received_request'
        except:
            return None

class SentTransactionSerializer(serializers.ModelSerializer):
    type = serializers.SerializerMethodField()
    account_id = serializers.UUIDField(source='receiver_account.account_id',read_only=True)
    full_name =serializers.SerializerMethodField()
    class Meta:
        model = Transaction
        fields = ['transaction_id','full_name','account_id','amount','date','status','transaction_type','type']
        
    def get_full_name(self, obj):
        try:
            kyc_record = KYC.objects.get(account=obj.receiver_account)
            return kyc_record.full_name
        except KYC.DoesNotExist:
            return None
        
    def get_type(self,obj):
        return self.context.get('type')
class ReceivedTransactionSerializer(serializers.ModelSerializer):
    type = serializers.SerializerMethodField()
    account_id = serializers.UUIDField(source='sender_account.account_id',read_only=True)
    full_name =serializers.SerializerMethodField()
    class Meta:
        model = Transaction
        fields = ['transaction_id','full_name','account_id','amount','date','status','transaction_type','type']
        
    def get_full_name(self, obj):
        try:
            kyc_record = KYC.objects.get(account=obj.sender_account)
            return kyc_record.full_name
        except KYC.DoesNotExist:
            return None
    
    def get_type(self,obj):
        return self.context.get('type')
    