FROM java:7-jdk
MAINTAINER Sami Mäkinen <zakarfin@gmail.com>

ENV TEMP_DIR /opt/tmp
RUN mkdir -p "$TEMP_DIR"
ENV ZIP_NAME jetty-8.1.16-oskari.zip
ENV OSKARI_ZIP_URL http://www.oskari.org/build/server/$ZIP_NAME
RUN set -x \
    && curl -fSL "$OSKARI_ZIP_URL" -o "$TEMP_DIR/$ZIP_NAME"
WORKDIR $TEMP_DIR
RUN unzip "$TEMP_DIR/$ZIP_NAME" -d "$TEMP_DIR"
RUN set -x \
    && mv "$TEMP_DIR/jetty-8.1.16-oskari" "/opt"\
    && rm -r "$TEMP_DIR"
EXPOSE 8080
WORKDIR /opt/jetty-8.1.16-oskari
ADD oskari-ext.properties /opt/jetty-8.1.16-oskari/resources
CMD ["java", "-jar", "start.jar"]
