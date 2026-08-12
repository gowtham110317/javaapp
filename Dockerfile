# Stage 1: Build the application using standard maven
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app

# Install maven via apt-get
RUN apt-get update && apt-get install -y maven

COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]