BUILDKIT_DOCKER_BUILD    = DOCKER_BUILDKIT=1 docker build
SINDAN_FLUENTD_TAG       = ghcr.io/sindan/sindan-docker/fluentd:latest
SINDAN_VISUALIZATION_TAG = ghcr.io/sindan/sindan-docker/visualization:latest
SINDAN_GRAFANA_TAG       = ghcr.io/sindan/sindan-docker/grafana:latest

.PHONY: all
all: run

.PHONY: lint
lint: fluentd/Dockerfile visualization/Dockerfile
	docker run --rm -i hadolint/hadolint < fluentd/Dockerfile || true
	docker run --rm -i hadolint/hadolint < visualization/Dockerfile || true
	docker run --rm -i hadolint/hadolint < grafana/Dockerfile || true

.PHONY: build
build:
	git submodule update --init --recursive
	docker compose pull mysql
	docker compose build

.PHONY: push
push:
	docker push $(SINDAN_FLUENTD_TAG)
	docker push $(SINDAN_VISUALIZATION_TAG)
	docker push $(SINDAN_GRAFANA_TAG)

.PHONY: pull
pull:
	docker pull $(SINDAN_FLUENTD_TAG)
	docker pull $(SINDAN_VISUALIZATION_TAG)
	docker pull $(SINDAN_GRAFANA_TAG)

.PHONY: init
init:
	docker compose up -d mysql
	docker compose run --rm visualization bundle exec rails db:migrate
	docker compose run --rm visualization bundle exec rails db:seed
	docker compose stop mysql visualization
	docker compose rm -f

.PHONY: migrate
migrate:
	docker compose up -d mysql visualization
	docker compose run --rm visualization bundle exec rails db:migrate
	docker compose stop mysql visualization
	docker compose rm -f

.PHONY: run
run:
	docker compose up -d fluentd mysql visualization grafana

.PHONY: runtls
runtls:
	docker compose up -d fluentd mysql visualization-noexpose grafana-noexpose caddy

.PHONY: log
log:
	docker compose logs -f --tail=100

.PHONY: ps
ps:
	docker compose ps -a

.PHONY: update
update:
	git pull origin master
	git submodule update --init --recursive

.PHONY: backup
backup:
	docker compose up -d mysql
	docker compose exec mysql /dump_database.sh | gzip > sindan_database_$(shell date +%Y-%m%d-%H%M%S).sql.gz

.PHONY: restore
restore:
	docker compose up -d mysql
	bash -c \
	'while true; do \
		gzip -d -c restore.sql.gz | docker compose exec -T mysql /restore_database.sh; \
		(( $$? == 0 )) && break; \
		echo -e "\n\nRetrying in 5 seconds ..."; sleep 5; echo; \
	done'
	docker compose stop mysql
	docker compose rm -f

.PHONY: stop
stop:
	docker compose stop

.PHONY: clean
clean: stop
	docker compose rm -f

.PHONY: destroy
destroy:
	docker compose kill
	docker compose rm -f
	docker volume rm -f $(shell basename $(CURDIR))_fluentd-data
	docker volume rm -f $(shell basename $(CURDIR))_mysql-data
	docker volume rm -f $(shell basename $(CURDIR))_visualization-data
	docker volume rm -f $(shell basename $(CURDIR))_grafana-data
	docker volume rm -f $(shell basename $(CURDIR))_caddy_data
	docker volume rm -f $(shell basename $(CURDIR))_caddy_config
	docker rmi -f $(SINDAN_FLUENTD_TAG)
	docker rmi -f $(SINDAN_VISUALIZATION_TAG)
	docker rmi -f $(SINDAN_GRAFANA_TAG)
