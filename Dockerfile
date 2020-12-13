FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/nagesh1977/sping-mysql.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/sping-mysql /app
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/spring-boot-demo-0.0.1-SNAPSHOT.jar /app

ENTRYPOINT  ["java","-jar", "/app/spring-boot-demo-0.0.1-SNAPSHOT.jar"]