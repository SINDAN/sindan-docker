cd $(dirname $0)/..

IMAGE_TAG="$(grep 'image: sindan/fluentd' docker-compose.yml | awk '{print $2}')"
echo $IMAGE_TAG

pushd fluentd

BUILDKIT_HOST=tcp://0.0.0.0:1234 \
  buildctl build --no-cache --frontend dockerfile.v0 --local context=. --local dockerfile=. --progress plain \
    --output type=docker,name=$IMAGE_TAG | docker load

st=$?
(( $st > 0 )) && exit $st

popd

docker images
docker save $IMAGE_TAG | gzip > docker-fluentd/image.tar.gz
