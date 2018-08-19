# elasticsearch-cluster-kubernetes

This project is use to deploy Elastic-search cluster on Kubernetes, Here we are using Elasticsearch version 5.5.0 and you can use any version > 5.5.X in Dockerfile and follow the below steps for deployment. Kube-DNS should be deployed on Kubernetes and running.


#- clone repo
git clone https://github.com/pawankkamboj/elasticsearch-cluster-kubernetes.git

cd elasticsearch-cluster-kubernetes

#- build docker image and push on your private registry

docker build --rm -t elasticsearch:5.5.0 .

#- create elasticsearch headless service 

kubectl create -f master-service.yaml

#- create statefull set 3 node cluster, all master/data/ingest on all nodes, use file name all-pods.yaml

modify the [REGISTRY-NAME] value in elastic-statful.yaml with your registry url and also change your Kube-DNS domain name.

kubectl create -f all-pods.yaml

#- if you want to deploy each ES node on different set of nodes then us their respctive pods.yaml file

to set master true and other data/ingest false, use master-pods.yaml

similar use ingest-pods.yaml and client-pods.yaml and data-pods.yaml


# check health and status of elasticsearch cluster

curl http://elasticsearch-0.els-headless.default.svc.kubernetes:9200/_cat/nodes?v

curl http://elasticsearch-0.els-headless.default.svc.kubernetes:9200/_cat/health?v

# Note

all-pods.yaml is only for test purpose, for production, please use persistance storage to store data
