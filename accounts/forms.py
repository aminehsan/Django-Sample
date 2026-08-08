from django import forms
from django.contrib.auth.forms import AuthenticationForm, UsernameField


class LoginForm(AuthenticationForm):
    username = UsernameField(
        label="نام کاربری",
        widget=forms.TextInput(
            attrs={
                "autofocus": True,
                "class": "form-control",
                "placeholder": "username",
                "dir": "ltr",
            }
        ),
    )
    password = forms.CharField(
        label="رمز عبور",
        strip=False,
        widget=forms.PasswordInput(
            attrs={
                "autocomplete": "current-password",
                "class": "form-control",
                "placeholder": "password",
                "dir": "ltr",
            }
        ),
    )
    error_messages = {
        "invalid_login": "نام کاربری یا رمز عبور صحیح نیست.",
        "inactive": "این حساب کاربری فعال نیست.",
    }
