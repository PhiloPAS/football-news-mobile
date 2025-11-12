from django.urls import path
from authentication.views import login, register

app_name = 'authentication'

urlpatterns = [
    # Endpoint untuk fungsi login
    path('login/', login, name='login'),
    # Endpoint untuk fungsi register
    path('register/', register, name='register'),
]