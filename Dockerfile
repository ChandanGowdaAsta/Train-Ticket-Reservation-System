# Build Stage
FROM maven:3-jdk-8-alpine as build-stage

WORKDIR /home/ubuntu/train

# Copy only the necessary files from the build context
COPY /var/lib/jenkins/workspace/docker-compose/pom.xml /home/ubuntu/train/
COPY /var/lib/jenkins/workspace/docker-compose/src /home/ubuntu/train/src

# Build the application
RUN mvn clean package

# Final Stage
FROM tomcat:9.0.82-jdk8-corretto-al2

# Copy the built WAR file from the build stage to Tomcat webapps directory
COPY --from=build-stage /home/ubuntu/train/target/TrainBook-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/train.war
