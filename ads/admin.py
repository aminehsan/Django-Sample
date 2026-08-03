from django.contrib import admin
from .models import Ad


@admin.register(Ad)
class AdAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "created_at",
        "updated_at",
        "title",
        "description",
    )
    list_filter = (
        "created_at",
        "updated_at",
    )
    search_fields = ("title",)
