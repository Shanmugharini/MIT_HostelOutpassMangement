# Use Maven base image to build the WAR
FROM maven:3.9.6-eclipse-temurin-17 as build

# Set work directory
WORKDIR /app

# Copy entire project into container
COPY . .

# Package the WAR file using Maven
RUN mvn clean package

# Use Tomcat base image for runtime
FROM tomcat:9.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR from build stage and rename to ROOT.war
COPY --from=build /app/target/MIT_HostelOutpassMangement.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
