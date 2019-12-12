FROM openjdk:8

RUN apt-get update; apt-get -y install wget rsync && \
    TMPDIR=$(mktemp -d) && cd $TMPDIR && \
    wget https://ftp.ripe.net/tools/rpki/validator3/prod/generic/rpki-rtr-server-latest-dist.tar.gz && \
    tar vzxf rpki-rtr-server-latest-dist.tar.gz && \
    mkdir -p /opt/rpki-rtr-server && \
    mv -v rpki-rtr-server-*/* /opt/rpki-rtr-server && \
    rm -rf $TMPDIR

WORKDIR /opt/rpki-rtr-server

ENV SERVER_ADDRESS 0.0.0.0
ENV SERVER_PORT 8080
ENV RTR_SERVER_ADDRESS 0.0.0.0
ENV RTR_SERVER_PORT 8323
ENV RPKI_VALIDATOR_VALIDATED_OBJECTS_URI http://localhost:8080/api/objects/validated

CMD ["/usr/local/openjdk-8/bin/java", "-Xms128M", "-Xmx128M", "-XX:+ExitOnOutOfMemoryError", "-jar", "./lib/rpki-rtr-server.jar"]
