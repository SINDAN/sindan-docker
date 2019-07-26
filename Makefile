BUILDKIT_DOCKER_BUILD    = DOCKER_BUILDKIT=1 docker build
SINDAN_FLUENTD_TAG       = sindan-fluentd:v1.6-1
SINDAN_VISUALIZATION_TAG = sindan-visualization:2.6.3-alpine

build:
	docker-compose pull mysql
	$(BUILDKIT_DOCKER_BUILD) fluentd -t $(SINDAN_FLUENTD_TAG)
	$(BUILDKIT_DOCKER_BUILD) visualization -t $(SINDAN_VISUALIZATION_TAG) \
		--secret id=rails_secret,src=.secrets/rails_secret_key_base.txt \
		--secret id=db_pass,src=.secrets/db_password.txt

init: build
	docker-compose up -d mysql
	docker-compose run visualization bundle exec rails db:migrate
	docker-compose run visualization bundle exec rails db:seed
	docker-compose stop mysql visualization
	docker-compose rm -f

run:
	docker-compose up -d
