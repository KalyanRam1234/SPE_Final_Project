FROM maven

WORKDIR /app

# COPY .mvn/ .mvn
# COPY mvnw pom.xml ./
# RUN chmod +x ./mvnw
# RUN ./mvnw dependency:go-offline
# RUN ./mvnw clean test

# COPY src ./src

COPY ./target/bookapp-0.0.1-SNAPSHOT.jar ./

CMD mvn spring-boot:run
