FROM ubuntu:18.04 as plugins

RUN apt-get update && apt-get -y install curl apt-transport-https make gcc g++ && \
    curl -s https://packagecloud.io/install/repositories/sensu/community/script.deb.sh | bash && \
    apt-get -y install sensu-plugins-ruby && \
    /opt/sensu-plugins-ruby/bin/sensu-install -p kubernetes && \
    /opt/sensu-plugins-ruby/bin/sensu-install -p http


FROM ubuntu:18.04

RUN apt-get update && apt-get -y install curl apt-transport-https && \
    curl -s https://packagecloud.io/install/repositories/sensu/stable/script.deb.sh | bash  && \
    apt-get update && apt-get -y install sensu-go-agent && rm -rf /var/lib/apt/lists/*

COPY --from=plugins /opt/sensu-plugins-ruby /opt/sensu-plugins-ruby
COPY ./docker-entrypoint.sh /bin/docker-entrypoint.sh
EXPOSE 3031
CMD ["/bin/docker-entrypoint.sh"]
