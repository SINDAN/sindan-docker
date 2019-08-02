#!/bin/bash

N=5
STATUS=1

while (( $N > 0 )); do
  bundle install --without development test --jobs 4 --deployment && STATUS=0 && break
  echo 'Try bundle again ...'
  sleep 1
  N=$(( $N - 1 ))
done

exit ${STATUS}
