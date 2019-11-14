FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.3.1

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install repository-gcs --batch
