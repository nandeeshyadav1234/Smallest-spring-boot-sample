# Stage 1: Build the application
# Use a specific Maven image with a JDK
FROM maven:3.8.1-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file first to allow Docker to cache dependencies
COPY pom.xml .

# Download dependencies (this layer is cached)
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Package the application into a JAR file
RUN mvn clean package -DskipTests

# Stage 2: Create the final runtime image
# Use a minimal JRE image
FROM openjdk:17-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the 'build' stage to the current stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your application runs on (commonly 8080 for web apps)
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
