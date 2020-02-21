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
