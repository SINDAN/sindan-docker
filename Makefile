BUILDKIT_BUILD = DOCKER_BUILDKIT=1 docker build

build:
	$(BUILDKIT_BUILD) visualization --secret id=rails_secret,src=.secrets/rails_secret_key_base.txt -t production
