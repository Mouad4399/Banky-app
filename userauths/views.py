# from django.shortcuts import render,redirect
# from userauths.forms import UserRegisterForm
# from django.contrib.auth import authenticate , login
# from django.contrib import messages
# def RegisterView(request):
    
#     if request.method == "POST":
#         # request.POST is dictionary 
#         # because I can use this == > request.POST.get("username") to get username or email or any field in the form
#         # so to create a User Record in the database use from=UserRegisterForm( and use dictionary here with the correct key/value)
#         # and hit form.save()
#         form = UserRegisterForm(request.POST)
        
#         if form.is_valid():
#             user=form.save()
#             # messages.success(request , f"Hey {request.POST['username']} you are logged in")
#             # new_user = authenticate(username=form.cleaned_data['email'],password= form.cleaned_data['password'])
#             login(request,user)
#             return redirect("home_page")
#     if request.user.is_authenticated:
#         print(request.user)
#         # messages.warning(request,f" {request.POST['username']} You are already signed Up !")
#         return redirect("home_page")
#     else:
#         print(request.user)
#         print(request.user.id)
#         form = UserRegisterForm()
#     context= {
#         "form":form
#     }
#     return render(request,'userauths/sign-up.html', context)
 
 
 
# from rest_framework.views import APIView
# from rest_framework.response import Response
# from rest_framework import status
# from django.contrib.auth import authenticate, login
# from .serializers import UserRegisterSerializer
# from userauths.forms import UserRegisterForm

# class RegisterView(APIView):
#     def post(self, request):
#         form = UserRegisterForm(request.data)
#         if form.is_valid():
#             user=form.save()
#             # user.set_password(user.password)
#             # user.save()
#             # new_user = authenticate(username=form.cleaned_data['email'],password= form.cleaned_data['password'])
#             # login(request,user,backend='django.contrib.auth.backends.ModelBackend')
#             # print(request.user)
#             login(request._request, request.user)
#             return Response(form.data, status=status.HTTP_201_CREATED)
#         return Response(form.errors, status=status.HTTP_400_BAD_REQUEST)

#     def get(self, request):
#         print(request.user)
#         if request.user.is_authenticated:
#             return Response({"message": f"{request.user.username}, you are already signed up!"}, status=status.HTTP_200_OK)
#         return Response({"message": "Please sign up."}, status=status.HTTP_200_OK)

 
 
 
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from .serializers import UserRegisterSerializer

@api_view(['POST'])
def register_user(request):
    if request.method == 'POST':
        serializer = UserRegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


from account.models import Account,KYC
from .serializers import KYCSerializer
@api_view(['POST','GET'])
@permission_classes([IsAuthenticated])
def kyc_registration(request):
    if request.method == 'POST':
        user= request.user.id
        account= Account.objects.get(user=user).id
        
        print(request.data)
        request.data['user']=user
        request.data['account']=account
        serializer = KYCSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    elif request.method == 'GET':
        try:
            user_kyc =KYC.objects.get(user=request.user.id)
        except KYC.DoesNotExist:
            return Response({'detail': 'KYC record not found.'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = KYCSerializer(user_kyc)
        return Response(serializer.data, status=status.HTTP_200_OK)
       
import os    
from django.http import FileResponse,Http404,HttpResponseForbidden,HttpResponse,JsonResponse
from django.conf import settings         
# @permission_classes([IsAuthenticated])
def get_file(request,file):
    token_key = request.GET.get('token')

    if token_key:
        try:
            token = Token.objects.get(key=token_key)
            user= token.user_id
            user_kyc =KYC.objects.get(user=user)
            data = KYCSerializer(KYC.objects.get(pk=user_kyc.id)).data
            data_relative_path = data.get(file)
            if not data_relative_path :
                return JsonResponse({'detail': "data does not exist"})
            file_path = os.path.join(settings.BASE_DIR, data_relative_path[1:])
            if os.path.exists(file_path):
                return FileResponse(open(file_path, 'rb'))
            else:
                raise JsonResponse({'detail': "data does not exist"})
        except Token.DoesNotExist:
            return JsonResponse({'detail': "invalid token"})

    return JsonResponse({'detail': "your are not authorized to access this file"})


from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.core.exceptions import ObjectDoesNotExist

from .models import User

@api_view(['POST'])
def user_login(request):
    if request.method == 'POST':
        username = request.data.get('username')
        password = request.data.get('password')

        user = None
        if '@' in username:
            try:
                user = User.objects.get(email=username)
            except ObjectDoesNotExist:
                pass

        if user:
            user = authenticate(request,username=username, password=password)
        if user:
            token, _ = Token.objects.get_or_create(user=user)
            return Response({'token': token.key}, status=status.HTTP_200_OK)

        return Response({'detail': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)





from rest_framework.authtoken.models import Token


from rest_framework.response import Response
from rest_framework import status

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def user_logout(request):
    if request.method == 'POST':
        try:
            # Delete the user's token to logout
            request.user.auth_token.delete()
            return Response({'detail': 'Successfully logged out.'}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def test(request):
    if request.method == 'POST':
        # If the token is valid, the code below will run
        # Perform some sensitive action
        try:
            # For example, processing data or performing an update
            data = UserRegisterSerializer(User.objects.get(pk=request.user.id)).data
            print(request.user.auth_token)
            # Process the data here
            print(f"this recieved data: {data}")

            return Response({'detail': 'Action performed successfully!' , 'extra_data': data}, status=status.HTTP_200_OK)
        
        except Exception as e:
            return Response({'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)