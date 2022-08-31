#### CREACION DEL JAR ####
FROM maven:3-jdk-11-slim AS builder

WORKDIR /app
COPY ./pom.xml .
RUN mvn -e -B dependency:go-offline
COPY ./src ./src
RUN mvn -Dmaven.test.skip=true clean package


#### FASE FINAL DE LA IMAGEN ####
FROM openjdk:11-jdk-slim

WORKDIR /workspace

ENV host="mysql_server"
ENV port="3306"
ENV database="demobd"
ENV username="root"
ENV password="toor"

COPY --from=builder /app/target/api*.jar app.jar

# COPY app.jar /apache/standalone/app.jar

#no abre ningun puerto, es solo informativo
EXPOSE 8080 
ENTRYPOINT exec java -jar /workspace/app.jar