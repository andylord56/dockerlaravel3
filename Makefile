.PHONY: dshell


dshell:
	echo "http://0.0.0.0:8080/" > public/hot
	docker-compose up -d nginx
	docker-compose run --service-ports --rm --entrypoint=bash php

setup:
	php artisan key:generate
	php artisan migrate
	php artisan db:seed
	npm ci
	npm run dev

dbmig:
	php artisan db:wipe
	php artisan migrate
	php artisan db:seed

test:
	php artisan test

node-assets:
	npm install
	npm run watch

build-nginx:
	docker image build -t pingcrm-nginx:latest --target nginx .

build-fpm:
	# docker image build --target test .
	docker image build -t pingcrm-fpm:latest --target fpm .
