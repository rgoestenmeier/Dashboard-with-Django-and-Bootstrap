PREFIX_PKG := dashboard-with-django-and-bootstrap

APP_NAME          := dashboard
APP_DIR           := $(APP_NAME)

BOOTSTRAP_VERSION := 4.4.1
BOOTSTRAP_DEST    := $(APP_DIR)/static/vendor/bootstrap

JQUERY_VERSION := 3.4.1
JQUERY_DEST    := $(APP_DIR)/static/vendor/jquery

POPPER_VERSION := 2.0.6
POPPER_DEST    := $(APP_DIR)/static/vendor/popper
POPPER_LINK    := https://github.com/popperjs/popper-core/archive/v$(POPPER_VERSION).zip

default:
	grep -E '^[^ ]+:.+#' Makefile

clearcache:                                                # Clear Cache
	python3 manage.py clear_cache

run:                                                       # Run Server
	python3 manage.py runserver 9000

deploy:                                                    # Deploy
	rm -rf dist $(PREFIX_PKG)*
	rm -rf polls.dist
	cd polls && python3 setup.py sdist
	mkdir polls.dist && mv polls/dist/* polls/$(PREFIX_PKG)* polls.dist

clearmigrations:                                           # Clear old migration files
	rm main/apps/*/migrations/0*py
	python3 manage.py clear_cache

makemigrations:                                            # Make migrations
	python3 manage.py  makemigrations

migrate:                                                   # Migrate database
	python3 manage.py migrate

createsuperuser:                                           # Create Superuser
	python3 manage.py createsuperuser

dbshell:                                                   # Run dbshell
	python3 manage.py  dbshell

# require pip install django-extensions
showurls:                                                  # Show URLs
	python3 manage.py  show_urls


download-bootstrap:                                        # Bootstrap: download source
	# https://github.com/twbs/bootstrap/archive/v4.4.1.zip
	mkdir -p install/bootstrap
	wget  -q https://github.com/twbs/bootstrap/archive/v$(BOOTSTRAP_VERSION).zip                                               -O install/bootstrap/$(BOOTSTRAP_VERSION).zip
	wget  -q https://github.com/twbs/bootstrap/releases/download/v$(BOOTSTRAP_VERSION)/bootstrap-$(BOOTSTRAP_VERSION)-dist.zip -O install/bootstrap/$(BOOTSTRAP_VERSION)-dist.zip

copy-bootstrap:                                            # Bootstrap: copy files to app
	rm -rf   ${BOOTSTRAP_DEST}/bootstrap-$(BOOTSTRAP_VERSION)-dist
	unzip -q install/bootstrap/$(BOOTSTRAP_VERSION)-dist.zip -d       ${BOOTSTRAP_DEST}/
	#
	rm -rf   ${BOOTSTRAP_DEST}/$(BOOTSTRAP_VERSION)
	mv       ${BOOTSTRAP_DEST}/bootstrap-$(BOOTSTRAP_VERSION)-dist ${BOOTSTRAP_DEST}/$(BOOTSTRAP_VERSION)

install-bootstrap: download-bootstrap copy-bootstrap       # Install Bootstrap
	@echo Download and Copy Bootstrap


install-jquery:                                            # jQuery: Install from Source
	# https://code.jquery.com/jquery-3.4.1.min.js
	# https://code.jquery.com/jquery-3.4.1.js
	#
	# https://code.jquery.com/jquery-3.4.1.slim.min.js
	# https://code.jquery.com/jquery-3.4.1.slim.js
	#
	mkdir -p ${JQUERY_DEST}/$(JQUERY_VERSION)/js
	wget -q https://code.jquery.com/jquery-$(JQUERY_VERSION).min.js      -O ${JQUERY_DEST}/$(JQUERY_VERSION)/js/jquery.min.js
	wget -q https://code.jquery.com/jquery-$(JQUERY_VERSION).slim.min.js -O ${JQUERY_DEST}/$(JQUERY_VERSION)/js/jquery.slim.min.js
	
install-popperjs:                                          # Install popperjs
	mkdir -p ${POPPER_DEST}/$(POPPER_VERSION)/js
	wget  -q https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js          -O ${POPPER_DEST}/$(POPPER_VERSION)/js/popper.min.js
	wget  -q https://unpkg.com/@popperjs/core@2.0.6/dist/umd/popper.min.js.map  -O ${POPPER_DEST}/$(POPPER_VERSION)/js/popper.min.js.map
	#
	#
	# mkdir -p install
	# rm -rf   ${POPPER_DEST}/$(POPPER_VERSION)
	# mkdir -p ${POPPER_DEST}/$(POPPER_VERSION)
	#
	# wget  -q $(POPPER_LINK)                       -O install/$(POPPER_VERSION).zip
	# unzip -q install/$(POPPER_VERSION).zip        -d ${POPPER_DEST}/$(POPPER_VERSION)/

#
#
#
AZ_SUBSCRIPTION_ID := #

AZ_APPNAME := django-dashboard
AZ_APPGROUP := linux_westeurope
AZ_LOCATION := westeurope

AZ_DBNAME := vdjango-dashboard
AZ_DBHOST := $(AZ_DBNAME).postgres.database.azure.com

AZ_DBUSER_NAME := manager@dashboard
AZ_DBUSER_PASS := mnager

AZ_DBADMIN_NAME := admin
AZ_DBADMIN_PASS := admin

AZ_DEPLOY_USR := deploy
AZ_DEPLOY_PWD := deploy

LOCAL_IP := #

PREFIX_PKG := dashboard

local_run:                            # run django app
	. setenv_local && python manage.py runserver

az_run:                         # run django app on azure
	. setenv_azure && python manage.py runserver

az_webapp-create:               # create azure web app in app services
	az webapp up --sku F1       --name $(AZ_APPNAME)                                                \
	                            --resource-group $(AZ_APPGROUP)                                     \
	                            --location $(AZ_LOCATION)

az_webapp-deploy:               # depoy changes to app services
	az webapp up --sku F1       --name $(AZ_APPNAME)                                                \
	                            --location $(AZ_LOCATION)


az_webapp-config-environment:   # configure webapp environment
	az webapp config appsettings set                                                                \
	                            --name           $(AZ_APPNAME)                                      \
	                            --resource-group $(AZ_APPGROUP)                                     \
	                            --settings  DBHOST="$(AZ_DBNAME).postgres.database.azure.com"       \
	                                        DBUSER="$(AZ_DBUSER_NAME)"                              \
	                                        DBPASS="$(AZ_DBUSER_PASS)"                              \
	                                        DBNAME="$(AZ_DBNAME)"


az_webapp-ssh:
	az webapp  ssh                                                                                  \
	                            --name           $(AZ_APPNAME)                                      \
	                            --resource-group $(AZ_APPGROUP)                                     \

az_init-console-log:            # init access to console logs
	az webapp log config    --name  $(AZ_APPNAME)                                   \
	                        --resource-group $(AZ_APPGROUP)                         \
	                        --docker-container-logging filesystem

az_show-console-log:            # show console log
	az webapp log tail      --name  $(AZ_APPNAME) --resource-group $(AZ_APPGROUP)


az_postgres-create:             # create azure postgress database
	az postgres server create   --resource-group $(AZ_APPGROUP)                                 \
	                            --name           $(AZ_DBNAME)                                   \
	                            --admin-user     $(AZ_DBADMIN_NAME)                             \
	                            --admin-password $(AZ_DBADMIN_PASS)                             \
	                            --auto-grow      Disabled                                       \
	                            --location       $(AZ_LOCATION)                                 \
	                            --sku-name       B_Gen5_1

az_postgres-firewall:           # create firewall rules
	az postgres server firewall-rule create                                                     \
	                            --resource-group $(AZ_APPGROUP)                                 \
	                            --server-name    $(AZ_DBNAME)                                   \
	                            --start-ip-address=$(LOCAL_IP)                                  \
	                            --end-ip-address=$(LOCAL_IP)                                    \
	                            --name AllowAllAzureIPs

az_deploy-create-user:
	az webapp deployment user set --user-name $(AZ_DEPLOY_USR) --password $(AZ_DEPLOY_PWD)

az_deploy-create-serviceplan:
	az appservice plan create --name serviceplan --resource-group $(AZ_APPGROUP) --sku F1 --is-linux


az_help-list-locations:         # list locations
	az account list-locations 

#
#
#
postgres-start:			        # start postgresql database server
	pg_ctl -D /usr/local/var/postgres start

postgres-stop:			        # stop postgresql database server
	pg_ctl -D /usr/local/var/postgres stop

postgres-psql:
	psql                        -h $(AZ_DBNAME).postgres.database.azure.com         \
	                            -U $(AZ_DBADMIN_NAME)@$(AZ_DBNAME) postgres
