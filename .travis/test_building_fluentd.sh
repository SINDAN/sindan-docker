cd $(dirname $0)/..

IMAGE_TAG="$(grep 'image: sindan-fluentd' docker-compose.yml | awk '{print $2}')"

pushd fluentd

BUILDKIT_HOST=tcp://0.0.0.0:1234 \
  buildctl build --frontend dockerfile.v0 --local context=. --local dockerfile=. --progress plain \
    --output type=docker,name=$IMAGE_TAG | docker load

popd

docker save $IMAGE_TAG | gzip > docker/fluentd.tar.gz
