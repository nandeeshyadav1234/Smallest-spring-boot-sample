FROM eclipse-temurin:11-jre AS runtime
WORKDIR /app

# This COPY command now works because 'build' is defined above
COPY --from=build /app/target/example.smallest-*.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
