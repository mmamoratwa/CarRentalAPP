# Step 1: Build the application using Maven and Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN cd carrentalapi && mvn clean package -DskipTests

# Step 2: Create the runtime environment with a slim Java 17 JRE
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/carrentalapi/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
