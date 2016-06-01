from django.conf.urls import include, url
from django.contrib import admin
from webpage import views as webpage_views

urlpatterns = [
    # Examples:
    # url(r'^$', 'arcus_web.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', admin.site.urls),
    url(r'^greetings/', webpage_views.greetings),
    url(r'^greetings_arcus/', webpage_views.greetings_arcus),
]
