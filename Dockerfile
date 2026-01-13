# === Stage 1: Build the application ===
FROM eclipse-temurin:11-jdk AS builder
WORKDIR /app
# Copy the Maven pom.xml and source code to leverage Docker cache
COPY pom.xml .
RUN mvn dependency:resolve # Resolve dependencies first
COPY src ./src
RUN mvn package -DskipTests # Build the application JAR

# === Stage 2: Create the final runtime image ===
# Use a lightweight JRE base image
FROM eclipse-temurin:11-jre
WORKDIR /app

# Create a non-root user and group for security best practices
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring

# Copy the JAR file from the 'builder' stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
