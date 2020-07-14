FROM maven:alpine AS sessionRestrictorBuilder

RUN apk update && apk add git
RUN git clone https://github.com/dasniko/keycloak-session-restrictor.git
WORKDIR /keycloak-session-restrictor
RUN mvn clean package

FROM quay.io/keycloak/keycloak

COPY --from=sessionRestrictorBuilder /keycloak-session-restrictor/target/keycloak-session-restrictor-0.0.1-SNAPSHOT.jar /opt/jboss/keycloak/providers/

ENTRYPOINT [ "/opt/jboss/docker-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
