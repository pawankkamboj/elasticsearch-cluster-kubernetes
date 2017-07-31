FROM centos:latest
MAINTAINER pawank.kamboj@gmail.com

#- install java
RUN yum -y install java && \
	yum clean all

#- elastic search version
ENV VERSION 5.5.0

#- donwload elastic search and set up user
RUN useradd elasticsearch && \
  ( curl -Lskj https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$VERSION.tar.gz | gunzip -c - | tar xf - ) && \
  mv elasticsearch-$VERSION /home/elasticsearch/elasticsearch && \
  rm -rf $(find /home/elasticsearch/elasticsearch | egrep "(\.(exe|bat)$)")

#- copy config
COPY config/elasticsearch.yml /home/elasticsearch/elasticsearch/config/elasticsearch.yml

# Set environment
ENV DISCOVERY_SERVICE elasticsearch-discovery
ENV CLUSTER_NAME elasticsearch-test

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
