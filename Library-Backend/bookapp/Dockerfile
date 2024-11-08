FROM eclipse-temurin:17-jdk-focal

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x ./mvnw
RUN ./mvnw dependency:go-offline
RUN ./mvnw clean test

COPY src ./src

CMD ./mvnw clean test && ./mvnw spring-boot:run
