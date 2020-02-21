# Dashboard with Bootstrap and Django

Building a Dashboard with [Bootstrap](https://getbootstrap.com/) and [Django](https://www.djangoproject.com/)

## Get started with Django

### Create Django Project

```bash
django-admin createproject dashboard
cd dashboard
```

### Prepare base Django app

```bash
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py run
```

### Get Bootstrap sources

```bash
mkdir -p install/bootstrap
wget  -q https://github.com/twbs/bootstrap/archive/v4.4.1.zip                                               -O install/bootstrap/4.4.1.zip
wget  -q https://github.com/twbs/bootstrap/releases/download/v4.4.1/bootstrap-4.4.1-dist.zip -O install/bootstrap/4.4.1-dist.zip
rm -rf   dashboard/static/vendor/bootstrap/bootstrap-4.4.1-dist
unzip -q install/bootstrap/4.4.1-dist.zip -d       dashboard/static/vendor/bootstrap/
#
rm -rf   dashboard/static/vendor/bootstrap/4.4.1
mv       dashboard/static/vendor/bootstrap/bootstrap-4.4.1-dist dashboard/static/vendor/bootstrap/4.4.1
```

### Reqires JavsScript Frameworks

https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js
https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js
