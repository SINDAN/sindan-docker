cd $(dirname $0)/..

IMAGE_TAG="$(grep 'image: sindan-visualization' docker-compose.yml | awk '{print $2}')"

pushd visualization

BUILDKIT_HOST=tcp://0.0.0.0:1234 \
 buildctl build --frontend dockerfile.v0 --local context=. --local dockerfile=. --progress plain \
   --secret id=rails_secret,src=../.secrets/rails_secret_key_base.txt \
   --secret id=db_pass,src=../.secrets/db_password.txt \
   --output type=docker,name=$IMAGE_TAG | docker load

popd

docker save $IMAGE_TAG | gzip > docker/visualization.tar.gz
