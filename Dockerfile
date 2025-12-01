From openjdk:8-jdk-slim
add jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar ttrend_dev.jar
ENTRYPOINT ["java","-jar","ttrend_dev.jar"]
