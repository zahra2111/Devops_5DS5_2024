FROM openjdk:17
EXPOSE 8089

RUN curl -o gestion-station-ski-1.0.jar -L "http://192.168.33.10:8081/repository/maven-releases/tn/esprit/spring/gestion-station-ski/1.0/gestion-station-ski-1.0.jar"

ENTRYPOINT ["java", "-jar", "gestion-station-ski-1.0.jar", "--spring.profiles.active=prod"]