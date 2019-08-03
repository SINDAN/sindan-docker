cd $(dirname $0)/..

IMAGE_TAG_FLUENTD="$(grep 'image: sindan/fluentd' docker-compose.yml | awk '{print $2}')"
IMAGE_TAG_VISUALIZATION="$(grep 'image: sindan/visualization' docker-compose.yml | awk '{print $2}')"

docker login docker.pkg.github.com --username "$GITHUB_PKG_USERNAME" --password "$GITHUB_PKG_TOKEN"

(( $? > 0 )) && exit 1

PREFIX=docker.pkg.github.com/sindan/sindan-docker
IMAGE_FLUENTD=$(echo $IMAGE_TAG_FLUENTD | cut -d '/' -f 2)
IMAGE_VISUALIZATION=$(echo $IMAGE_TAG_VISUALIZATION | cut -d '/' -f 2)

docker tag $IMAGE_TAG_FLUENTD $PREFIX/$IMAGE_FLUENTD
docker tag $IMAGE_TAG_VISUALIZATION $PREFIX/$IMAGE_VISUALIZATION

docker push $PREFIX/$IMAGE_FLUENTD
docker push $PREFIX/$IMAGE_VISUALIZATION

