FROM jfrogjd-docker.jfrog.io/openjdk-8-alpine
ARG JAR_FILE=target/websocket-demo-0.0.1-SNAPSHOT.jar

ENV PORT 8080
EXPOSE 8080
ADD ${JAR_FILE} /opt/target/websocket-demo.jar
WORKDIR /opt/target

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","websocket-demo.jar"]