# elasticsearch-cluster-kubernetes

This project is use to deploy Elastic-search cluster on Kubernetes, Here we are using Elatsic-search version 5.5.0 and follow the below steps for deployment. Kube-DNS should be deployed on Kubernetes and running.

#- build docker image and push on your private registry
docker build --rm -t elasticsearch:5.5.0 .

#- create elasticsearch headless service 
kubectl create -f elastic-headless.yaml

#- create statefull set 3 node cluster
kubectl create -f elastic-stateful.yaml

http://172.16.7.231:9200/_cat/health?v
http://172.16.7.100:9200/_cat/nodes?v




