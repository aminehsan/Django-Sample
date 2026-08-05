from django.views.generic import ListView
from .models import Ad


class AdListView(ListView):
    model = Ad
    template_name = "list.html"
    context_object_name = "ads"
