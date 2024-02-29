# SWE645 Assignment Dockerfile - Provides the docker containerization commands
# Author: Sri Harish Jayaram

FROM tomcat:8.0-alpine

# Copy WAR file into the Tomcat webapps directory
COPY ./target/swe645_Assignment2.war /usr/local/tomcat/webapps/

# Expose port default Tomcat port 8080
EXPOSE 8080

# Starts the Tomcat server when the container starts
CMD ["catalina.sh", "run"]
