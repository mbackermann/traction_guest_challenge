build:
	docker-compose build

migrate:
	docker-compose run web rake db:create db:migrate

start:
	docker-compose up
