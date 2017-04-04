FROM jboss/base-jdk:8

# build argument: docker build keycloak --build-arg CA=".......X509 CERTIFICATE BASE64......"
ARG CA="-----BEGIN CERTIFICATE----- MIIGmTCCBIGgAwIBAgIJAMRCi4g4C17iMA0GCSqGSIb3DQEBCwUAMIGKMQswCQYD VQQGEwJGUjEMMAoGA1UECBMDSURGMQ4wDAYDVQQHEwVQQVJJUzEkMCIGA1UEChMb R0lFIEFYQSBURUNITk9MT0dZIFNFUlZJQ0VTMSQwIgYDVQQLExtHSUUgQVhBIFRF Q0hOT0xPR1kgU0VSVklDRVMxETAPBgNVBAMTCGF4YXh4Lm51MB4XDTE1MDMwNTAw NTE1NFoXDTI1MDMwMjAwNTE1NFowgYoxCzAJBgNVBAYTAkZSMQwwCgYDVQQIEwNJ REYxDjAMBgNVBAcTBVBBUklTMSQwIgYDVQQKExtHSUUgQVhBIFRFQ0hOT0xPR1kg U0VSVklDRVMxJDAiBgNVBAsTG0dJRSBBWEEgVEVDSE5PTE9HWSBTRVJWSUNFUzER MA8GA1UEAxMIYXhheHgubnUwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoIC AQC9/RtJNpuJ3ep/MWHyqC9IQnJ7ZDhc185yJ4esoWTWADr4YpTYz7clMpUpb6z/ LRJMwDrsgc2syYiR848c8+QiW3GzjhzMQg60Y3NfOpB9TMp/susSDarNlHYeeLu1 VrzHbiijVgfFBBOVyXGZaK9BhamGvLYnxaI/7+MBycIBzsKQd/hdHqNjVv/mMIfj fP9v0HN2dPuOvIxzlNTOoMeKXUZbV9TLGWlM5NLcCtOaIOYct4+Fi5uiMS9STyNI 5/JTHrXD7RDSf+e8YuTwLDsznxHJWYYqJu+uppTAa+rlOVDCLoV4S8QW5viQMQJU JSj9ZYa6P+Dr0KUeyJa+5RS3TfDtUlaz58WTnzZWXld232gdTuU5D1U18zhtxykv Thqusu88JPjs3B3oaiwhMcMqmQSGgsOFYEPTvRPhTPO5G9lkIkasULI54Fy0l6ag cfSMJmgWqG6kFRD+GpzePGYsejxL7LMpunUIr8wJYkvkvxQQHEyXqLb1EGJmCK9m hL5i9zXxsLSJqwQeWyKrpZ46cDrukX3UaU5P/7zpsT+C1I544t6pej+40uL3Wt01 7ZK68cDUq5Li88xi3brz79MPaqrZh3Ydn0P9lUsYR5t1PExkeCEpziBzN/0Y/OwR oYSQjN7Qy4wYRcOrzkOtsMQe2RyfcHo2BWDHTk9c2jEeRwIDAQABo4H/MIH8MAwG A1UdEwQFMAMBAf8wHQYDVR0OBBYEFG7EUA44+/el4+rgOn0XHvyeTKpAMIG/BgNV HSMEgbcwgbSAFG7EUA44+/el4+rgOn0XHvyeTKpAoYGQpIGNMIGKMQswCQYDVQQG EwJGUjEMMAoGA1UECBMDSURGMQ4wDAYDVQQHEwVQQVJJUzEkMCIGA1UEChMbR0lF IEFYQSBURUNITk9MT0dZIFNFUlZJQ0VTMSQwIgYDVQQLExtHSUUgQVhBIFRFQ0hO T0xPR1kgU0VSVklDRVMxETAPBgNVBAMTCGF4YXh4Lm51ggkAxEKLiDgLXuIwCwYD VR0PBAQDAgHmMA0GCSqGSIb3DQEBCwUAA4ICAQCeQr35bV2+2Hej6SA6mn+NeEgz QdMxs5Qu/iJJTN6jxo0hENNNfpOk9sBq7wjWVk/o9GTGVAiHCithvHn4A309J/ol MNhhKH7klqD4Cd+eD/OyJOUFDL/P2m4Q4wMVcg5qtLYz7p30fCgBEE8uuJ2IsrTh FViWqUwBxdkulMHOFoUHi6m80nqB+j+QCKoVJUVMuLLN9Jg8coxXSqBfVaPi+eDk YC8spaa5Jl1sQXsTAaei/v5ZP0DlBUYg/Y/eHyOmRFJD1ahr2NGMkbsitMy4CHye kuZmbHuNkHnIApUtyIGB7Ef7VASTFd61bjIm1xpUvkY0a7CUSxORIT0PCqk2DDVT S+HjCCnHuknc4zjlEgPa29hytAF1iziOY0YJu0BiCIGruOymYJzJuwpFHhYLKjXZ fUPQtVTnIPMPstV7IVZ6B82ZXfB/gvgAS0DNT39Ad9i0PFXQrQil6jieq0zB7GLo nlK7GCscdfGEfE/ueX6AK25PVC4lbqWhdmltHYF5kyJtG5EwyLvAti9fDBGxb3yE lhYyGpLCOGpqlYFlUXsUxbxXBzcP81I3tn8M3IoL5U3DzjT9ClRM/KCKQXQlIXYo rCkTVoHn2Ox9/dRlfKtsr2X1b2nT336TomW8H/9zce6TdpCEfblpF8hPRs2bfrVR zh8HQJI4j4oilEWrWQ== -----END CERTIFICATE-----"
ARG CHECK_CURL="ldaps://ldapmaster-0.int.axa.xx:5636"

ENV KEYCLOAK_VERSION 3.0.0.Final
# Enables signals getting passed from startup script to JVM
# ensuring clean shutdown when container is stopped.
ENV LAUNCH_JBOSS_IN_BACKGROUND 1

USER root

ADD add-trusted-certificates.sh /opt/jboss

RUN yum install -y epel-release && yum install -y jq xmlstarlet && yum clean all && ./add-trusted-certificates.sh -d -c "$CHECK_CURL" -- "$CA"

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
