BUILDKIT_DOCKER_BUILD    = DOCKER_BUILDKIT=1 docker build
SINDAN_FLUENTD_TAG       = sindan-fluentd:v1.6-1
SINDAN_VISUALIZATION_TAG = sindan-visualization:2.6.3-alpine

.PHONY: all
all: run

.PHONY: lint
lint: fluentd/Dockerfile visualization/Dockerfile
	docker run --rm -i hadolint/hadolint < fluentd/Dockerfile || true
	docker run --rm -i hadolint/hadolint < visualization/Dockerfile || true

.PHONY: build
build:
	docker-compose pull mysql
	$(BUILDKIT_DOCKER_BUILD) fluentd -t $(SINDAN_FLUENTD_TAG)
	$(BUILDKIT_DOCKER_BUILD) visualization -t $(SINDAN_VISUALIZATION_TAG) \
		--secret id=rails_secret,src=.secrets/rails_secret_key_base.txt \
		--secret id=db_pass,src=.secrets/db_password.txt

.PHONY: init
init: build
	docker-compose up -d mysql
	bash -c \
	'while true; do \
		docker-compose run visualization bundle exec rails db:migrate; \
		(( $$? == 0 )) && break; \
		echo -e "\n\nRetrying in 5 seconds"; sleep 5; echo; \
	done'
	docker-compose run visualization bundle exec rails db:seed
	docker-compose stop mysql visualization
	docker-compose rm -f

.PHONY: run
run:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose stop

.PHONY: clean
clean: stop
	docker-compose rm -f

.PHONY: destroy
destroy:
	docker-compose kill
	docker-compose rm -f
	docker volume rm -f sindan-docker_fluentd-data
	docker volume rm -f sindan-docker_mysql-data
	docker volume rm -f sindan-docker_visualization-data
	docker rmi -f $(SINDAN_FLUENTD_TAG)
	docker rmi -f $(SINDAN_VISUALIZATION_TAG)
