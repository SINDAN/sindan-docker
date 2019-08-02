cd $(dirname $0)/..

IMAGE_TAG_FLUENTD="$(grep 'image: sindan/fluentd' docker-compose.yml | awk '{print $2}')"
IMAGE_TAG_VISUALIZATION="$(grep 'image: sindan/visualization' docker-compose.yml | awk '{print $2}')"

echo $DOCKER_HUB_USERNAME
sudo docker login --username "$DOCKER_HUB_USERNAME" --password "$DOCKER_HUB_PASSWORD"
docker push "$IMAGE_TAG_FLUENTD"
docker push "$IMAGE_TAG_VISUALIZATION"
