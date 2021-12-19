#! /bin/bash -e

kubectl apply -f <(cat deployment/kubernetes/stateful-services/*.yml)

#./deployment/kubernetes/scripts/kubernetes-wait-for-ready-pods.sh ftgo-mysql-0 ftgo-kafka-0 ftgo-dynamodb-local-0 ftgo-zookeeper-0

./deployment/kubernetes/scripts/kubernetes-wait-for-ready-pods.sh ftgo-mysql-0 ftgo-dynamodb-local-0

#kubectl create -f 'https://strimzi.io/install/latest?namespace=default'

kubectl apply -f <(cat deployment/kubernetes/stateful-services/strimzi-kafka-deployment.yml)

kubectl wait kafka/ftgo --for=condition=Ready --timeout=300s

kubectl apply -f <(cat deployment/kubernetes/cdc-service/*.yml)

kubectl apply -f <(cat */src/deployment/kubernetes/*.yml)
