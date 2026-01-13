

# Stage 2: Runtime (Your original code)
FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/target/example.smallest-0.0.1-SNAPSHOT.jar app.jar
# COPY target/example.smallest-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
