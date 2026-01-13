# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-11 AS build
WORKDIR /app

# Copy the specific subdirectory content into /app
# This puts your pom.xml directly in /app inside the container
COPY SmallestSpringApp/ .

# Run Maven from /app (where pom.xml now exists)
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:11-jre
WORKDIR /app

# Copy the JAR from the build stage's target folder
COPY --from=build /app/target/example.smallest-*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
