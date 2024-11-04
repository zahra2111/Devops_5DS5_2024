FROM openjdk:17-jdk-slim

WORKDIR /app

COPY ./target/ski_station_zahra.jar /app/app.jar

EXPOSE 8089

CMD ["java", "-jar", "/app/app.jar"]
