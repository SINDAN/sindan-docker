#!/bin/bash

N=5
STATUS=1

bundle config set --local deployment 'true'
bundle config set --local without 'deployment test'
while (( $N > 0 )); do
  bundle install --jobs 4 && STATUS=0 && break
  echo 'Try bundle again ...'
  sleep 1
  N=$(( $N - 1 ))
done

exit ${STATUS}
