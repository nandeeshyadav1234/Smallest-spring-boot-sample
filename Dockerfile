# Use a specific minor version tag for better reproducibility
FROM eclipse-temurin:11-jre

# Sets the internal working directory
WORKDIR /app

# Use a wildcard (*) so the build doesn't break when your project version updates
COPY target/example.smallest-*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
