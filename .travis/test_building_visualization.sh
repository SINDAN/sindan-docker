cd $(dirname $0)/..

IMAGE_TAG="$(grep 'image: sindan/visualization' docker-compose.yml | awk '{print $2}')"
echo $IMAGE_TAG

pushd visualization

BUILDKIT_HOST=tcp://0.0.0.0:1234 \
 buildctl build --no-cache --frontend dockerfile.v0 --local context=. --local dockerfile=. --progress plain \
   --opt build-arg:BUILDTIME_RAILS_SECRETKEY_FILE=/run/secrets/rails_secret_key_base \
   --opt build-arg:BUILDTIME_DB_PASSWORD_FILE=/run/secrets/db_password \
   --secret id=rails_secret,src=../.secrets/rails_secret_key_base.txt \
   --secret id=db_pass,src=../.secrets/db_password.txt \
   --output type=docker,name=$IMAGE_TAG | docker load

st=$?
(( $st > 0 )) && exit $st

popd

docker images
docker save $IMAGE_TAG | gzip > docker-visualization/image.tar.gz
