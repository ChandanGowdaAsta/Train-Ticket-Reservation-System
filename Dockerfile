FROM maven:3-jdk-8-alpine as build-stage
WORKDIR /home/ubuntu/train
COPY /var/lib/jenkins/workspace/docker-compose/ /home/ubuntu/train/
RUN mvn clean package
FROM tomcat:9.0.82-jdk8-corretto-al2
COPY --from=build-stage /home/ubuntu/train/target/TrainBook-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/train.war
