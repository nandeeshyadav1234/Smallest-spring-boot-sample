# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:11-jre
WORKDIR /app

# FIX: Use the specific folder Maven creates inside the build stage
# Ensure you do NOT have a leading slash on the destination 'app.jar'
COPY --from=build /app/target/example.smallest-*.jar ./app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
