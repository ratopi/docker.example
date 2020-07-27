# first container to build the application
FROM maven:3.6.3-jdk-11 AS BUILDER

WORKDIR /BUILD/

COPY ./ ./

RUN mvn package -DskipTests

#

# final container, holding only the jar
FROM openjdk:11.0.7-jdk

EXPOSE 8080

RUN groupadd java
RUN useradd -g java java

WORKDIR /APP/

RUN chown java.java /APP/

USER java

COPY --from=BUILDER /BUILD/target/docker.example-*.jar .

CMD java -jar docker.example-*.jar
