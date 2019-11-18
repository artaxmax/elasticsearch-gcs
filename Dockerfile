FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.3.1 as base

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install repository-gcs --batch
RUN mkdir /usr/share/elasticsearch/credentials

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["eswrapper"]
