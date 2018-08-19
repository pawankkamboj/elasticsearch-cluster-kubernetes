FROM centos:latest
MAINTAINER pawank.kamboj@gmail.com

#- install java
RUN yum -y install java && \
	yum clean all

#- elastic search version
ENV VERSION 5.6.2

#- donwload elastic search and set up user
RUN useradd elasticsearch && \
  ( curl -Lskj https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$VERSION.tar.gz | gunzip -c - | tar xf - ) && \
  mv elasticsearch-$VERSION /home/elasticsearch/elasticsearch && \
  rm -rf $(find /home/elasticsearch/elasticsearch | egrep "(\.(exe|bat)$)")

#- copy config
COPY elasticsearch.yml /home/elasticsearch/elasticsearch/config/elasticsearch.yml

# Set environment
ENV DISCOVERY_SERVICE="elasticsearch-discovery" CLUSTER_NAME="elasticsearch-default" \
	ES_JAVA_OPTS="-Xms1g -Xmx1g" \
	NODE_MASTER="true" NODE_DATA="true" NODE_INGEST="true" \
	HTTP_ENABLE="true" NETWORK_HOST="_site_" \
	HTTP_CORS_ENABLE="true" HTTP_CORS_ALLOW_ORIGIN="*" \
	NUMBER_OF_MASTERS="1" MAX_LOCAL_STORAGE_NODES="1" \
	SHARD_ALLOCATION_AWARENESS="" SHARD_ALLOCATION_AWARENESS_ATTR="" \
	MEMORY_LOCK="true"

#- provide env equal to exec
COPY su-exec /usr/local/bin/su-exec

#- add startup file
COPY run.sh /home/elasticsearch/elasticsearch/bin/run.sh

#- volume
VOLUME /home/elasticsearch/elasticsearch/data

#- expose port
EXPOSE 9200 9300

#- entrypoint
ENTRYPOINT ["/home/elasticsearch/elasticsearch/bin/run.sh"]
