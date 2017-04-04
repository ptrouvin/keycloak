FROM jboss/base-jdk:8

# build argument: docker build keycloak --build-arg=".......X509 CERTIFICATE BASE64......"
ARG CA

ENV KEYCLOAK_VERSION 3.0.0.Final
# Enables signals getting passed from startup script to JVM
# ensuring clean shutdown when container is stopped.
ENV LAUNCH_JBOSS_IN_BACKGROUND 1

USER root

RUN yum install -y epel-release && yum install -y jq xmlstarlet && yum clean all

ADD add-trusted-certificates.sh /opt/jboss

RUN ./add-trusted-certificates.sh "$CA"

USER jboss

RUN cd /opt/jboss/ && curl -sL https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz | tar zx && mv /opt/jboss/keycloak-$KEYCLOAK_VERSION /opt/jboss/keycloak

ADD docker-entrypoint.sh /opt/jboss/

ADD setLogLevel.xsl /opt/jboss/keycloak/
RUN java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml -xsl:/opt/jboss/keycloak/setLogLevel.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml
RUN xmlstarlet ed --inplace \
        -N x="urn:jboss:domain:undertow:3.0" \
        -a "//x:http-listener" \
        -t attr \
        -n 'proxy-address-forwarding' \
        -v 'true' \
        /opt/jboss/keycloak/standalone/configuration/standalone.xml

USER root

RUN chown -R jboss.0 /opt/jboss && chmod -R 770 /opt/jboss

USER jboss

ENV JBOSS_HOME /opt/jboss/keycloak

EXPOSE 8080

ENTRYPOINT [ "/opt/jboss/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]
