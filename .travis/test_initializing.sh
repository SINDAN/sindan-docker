cd $(dirname $0)/..

docker-compose up -d mysql

while true; do
  docker-compose run visualization bundle exec rails db:migrate
  (( $? == 0 )) && break
  sleep 5
done

docker-compose run visualization bundle exec rails db:seed
docker-compose stop mysql visualization
docker-compose rm -f
