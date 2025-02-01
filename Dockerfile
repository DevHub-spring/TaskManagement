FROM openjdk:21
EXPOSE 8080
ADD target/task-management.jar task-management.jar
ENTRYPOINT ["java","-jar","/task-management.jar"]