# Use the official eclipse-temurin JRE 11 image as the base runtime
FROM eclipse-temurin:11-jre

# Define an argument for the JAR file path, defaulting to a common Maven location
ARG JAR_FILE=target/*.jar

# Copy the built JAR file from your host machine into the container as 'app.jar'
COPY ${JAR_FILE} app.jar

# Expose the port your Spring Boot application listens on (default is 8080)
EXPOSE 8080

# Set the entry point command to run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
