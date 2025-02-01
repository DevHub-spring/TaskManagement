FROM openjdk:21
EXPOSE 8080
Add target/task-management.jar task-management.jar
ENTRYPOINT["java","-jar","/task-management.jar"]