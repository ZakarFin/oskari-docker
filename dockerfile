FROM debian:buster-slim as downloader

WORKDIR /home/root
ADD https://download.osgeo.org/oskari/oskari-latest-stable.zip .

FROM openjdk:8-jdk-alpine

ENV TEMP_DIR /opt/tmp
RUN mkdir -p $TEMP_DIR
COPY --from=downloader /home/root/oskari-latest-stable.zip $TEMP_DIR
# ENV ZIP_NAME oskari-latest-stable
WORKDIR $TEMP_DIR
RUN unzip "$TEMP_DIR/oskari-latest-stable.zip" -d "$TEMP_DIR"
RUN set -x \
    && mv "$TEMP_DIR/jetty-distribution-9.4.56.v20240826" "/opt"\
    && mv "$TEMP_DIR/oskari-server" "/opt"\
    && rm -r "$TEMP_DIR"\
    && sed -i -e 's/postgresql:\/\/localhost:5432/postgresql:\/\/oskari-db:5432/' /opt/oskari-server/resources/oskari-ext.properties\
    && sed -i -e 's/redis.hostname=localhost/redis.hostname=oskari-redis/' /opt/oskari-server/resources/oskari-ext.properties
EXPOSE 8080
WORKDIR /opt/oskari-server

CMD java -jar ../jetty-distribution-9.4.56.v20240826/start.jar
