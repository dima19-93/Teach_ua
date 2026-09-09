FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
RUN apk add --no-cache zip
COPY --from=build /app/target/dev.war ./app.war
COPY data.sql ./data.sql
RUN mkdir -p WEB-INF/classes && \
    cp data.sql WEB-INF/classes/data.sql && \
    zip -u app.war WEB-INF/classes/data.sql && \
    rm -rf WEB-INF
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]







