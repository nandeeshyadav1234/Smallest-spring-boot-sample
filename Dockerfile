# Stage 1: Build the JAR
FROM maven:3.8.8-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime (Your original code)
FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/target/example.smallest-*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
