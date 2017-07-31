#!/bin/bash
set -e

if [ $# -eq 0 ]
then
        chown elasticsearch.elasticsearch /home/elasticsearch -R
	# set memlock and map count
	ulimit -l unlimited
	sysctl -w vm.max_map_count=262144

        echo "starting elasticsearch"
        /usr/local/bin/su-exec elasticsearch /home/elasticsearch/elasticsearch/bin/elasticsearch
else
	exec "$@"
fi
