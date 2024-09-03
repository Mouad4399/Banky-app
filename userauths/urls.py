from django.urls import path
from userauths import views
app_name ='userauths'


urlpatterns=[
    # path('sign-up/',views.RegisterView , name=app_name)
    path('sign-up/',views.register_user , name='signup'),
    path('login/',views.user_login , name='login'),
    path('logout/',views.user_logout , name='logout'),
    path('test/',views.test , name='test'),
    path('kyc/',views.kyc_registration , name='kyc'),
    path('kyc/file/<str:file>', views.get_file, name='get-file'),
    path('acc/', views.get_account, name='get-acc'),
]
