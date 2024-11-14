FROM maven:3.8.4-openjdk-17-slim

WORKDIR /app

COPY pom.xml ./
COPY src ./src

RUN mvn dependency:go-offline

CMD ["mvn", "spring-boot:run"]