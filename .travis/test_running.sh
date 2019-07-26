cd $(dirname $0)/..

docker-compose up -d mysql fluentd visualization

# waiting for containers up (<20 sec)
i=20
while (( $i > 0 )); do
  echo -n . && sleep 1
  i=$(( $i - 1 ))
done
echo

# sindan-fluentd
curl -f -I http://localhost:8080 || exit 1

# sindan-visualization
curl -f -I http://localhost:3000 || exit 2
