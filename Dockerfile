FROM maven:3.9.8-amazoncorretto-21 AS build

WORKDIR /app

COPY pom.xml ./
COPY src ./src

RUN mvn clean install

FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=build /app/target/keycloakdemo-0.0.1.jar ./app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]