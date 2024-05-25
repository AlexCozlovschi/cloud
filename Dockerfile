# Use the OpenJDK 17 JDK slim base image
FROM openjdk:17-jdk-slim

# Copy the application files into the container
COPY . /app

# Set the working directory to /app
WORKDIR /app

# Ensure gradlew has Unix line endings
RUN apt-get update && apt-get install -y dos2unix && dos2unix gradlew

# Make gradlew executable
RUN chmod +x gradlew

# List files for debugging purposes
RUN ls

# Run the Gradle wrapper to build the jar file
RUN ./gradlew bootJar

# Use the OpenJDK 17 JDK slim base image again for the final stage
FROM openjdk:17-jdk-slim

# Copy the built jar file from the first stage
COPY --from=0 /app/build/libs/cloud-app-0.0.1-SNAPSHOT.jar /app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
# Set the entry point to run the jar file
ENTRYPOINT ["java", "-jar", "/app.jar"]

#docker build -t cloud-app:latest .
#docker run -it --name prasada cloud-app:latest
#docker run -it --name prasada -p 8080:8080 cloud-app:latest
#docker stop prasada
#docker rm prasda
