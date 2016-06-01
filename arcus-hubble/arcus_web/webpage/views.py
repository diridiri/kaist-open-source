from django.shortcuts import render
from .models import Count
from .arcus_python_client.arcus import Arcus, ArcusLocator, ArcusTranscoder
from .arcus_python_client.arcus_mc_node import  ArcusMCNodeAllocator

def get_arcus_client():

        ARCUS_ZK_ADDRESS = 'localhost:2181'
        ARCUS_SERVICE_CODE = 'test'
        client = Arcus(ArcusLocator(ArcusMCNodeAllocator(ArcusTranscoder())))
        client.connect(ARCUS_ZK_ADDRESS, ARCUS_SERVICE_CODE)
        return client



def greetings(request):
        if request.method == "POST":
                countings = Count.objects.filter(countname = "total_greetings")
                if countings.exists():
                        counter = countings[0]
                        counter.count +=1
                        counter.save()
                        return render(request, "greetings.html", {})
        return render(request, "greetings.html", {})

def greetings_arcus(request):
        arcus = get_arcus_client()
        if request.method == "POST":
                #countings = Count.objects.filter(countname = "total_greetings")
                key = "option:%d" % option_id
                ret = arcus.get(key).get_result()
                if not ret:
                        arcus.set(key, 1)
                else:
                        increase = arcus.set(key, ret+1)
                """
                countings =
                if countings.exists():
                        counter = countings[0]
                        counter.count +=1
                        counter.save()
                        return render(request, "greetings.html", {})
                else:
                        print "nono"
                """
        return render(request, "greetings_arcus.html", {})
