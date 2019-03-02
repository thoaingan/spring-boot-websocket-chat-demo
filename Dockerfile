FROM maven:3.5.4-jdk-8-alpine as BUILD

ARG ART_URL
ARG ART_USER
ARG ART_PASS

ENV ART_URL $ART_URL
ENV ART_USER $ART_USER
ENV ART_PASS $ART_PASS

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN apk add libc6-compat && \
    export M2_HOME=/usr/share/maven && \
    wget -c https://dl.bintray.com/jfrog/jfrog-cli-go/1.24.2/jfrog-cli-linux-amd64/jfrog && \
    chmod +x jfrog && \
    ./jfrog rt config jfrog-jd --url=$ART_URL --user=$ART_USER --password=$ART_PASS && \
    ./jfrog rt mvn "clean install" maven.yaml --build-name=mvn-jfrog --build-number=1

# RUN mvn --batch-mode -f /usr/src/app/pom.xml clean package

FROM openjdk:8-jdk
ENV PORT 8080
EXPOSE 8080
COPY --from=BUILD /usr/src/app/target /opt/target
WORKDIR /opt/target

CMD ["/bin/bash", "-c", "find -type f -name '*.jar' | xargs java -jar"]
