from rest_framework import serializers
from userauths.models import User
from account.models import KYC,Account

class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'email', 'password']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        user.save()
        
        # use this alternatively
        # user = CustomUser(
        #     username=validated_data['username'],
        #     email=validated_data['email']
        # )
        # user.set_password(validated_data['password'])
        # user.save()
        return user

class KYCSerializer(serializers.ModelSerializer):
    class Meta:
        model = KYC
        fields ='__all__'
        
        
class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields ='__all__'


    