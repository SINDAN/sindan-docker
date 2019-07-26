BUILDKIT_BUILD = DOCKER_BUILDKIT=1 docker build

SINDAN_FLUENTD_TAG = sindan-fluentd:v1.6-1
SINDAN_VISUALIZATION_TAG = sindan-visualization:2.6.3-alpine

build:
	$(BUILDKIT_BUILD) fluentd -t $(SINDAN_FLUENTD_TAG)
	$(BUILDKIT_BUILD) visualization -t $(SINDAN_VISUALIZATION_TAG) \
		--secret id=rails_secret,src=.secrets/rails_secret_key_base.txt \
		--secret id=db_pass,src=.secrets/db_password.txt
