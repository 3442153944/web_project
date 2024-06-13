# your_app/views.py
from django.http import JsonResponse
from django.views import View
from django.db import connection

class TestDBConnectionView(View):
    def get(self, request, *args, **kwargs):
        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                result = cursor.fetchone()
            if result:
                return JsonResponse({"status": "success", "message": "Database connection is working."})
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)})
