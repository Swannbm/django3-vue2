from django.shortcuts import render


def entry_point(request):
    return render(request, "front/index.html", context=dict())
