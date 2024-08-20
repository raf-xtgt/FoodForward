# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the target directory to the container
COPY target/*.jar app.jar

# Expose port 8080
EXPOSE 5001

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
