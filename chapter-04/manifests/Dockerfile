# syntax=docker/dockerfile:1
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN --mount=type=cache,target=/root/.m2 ./mvnw dependency:go-offline -q
COPY src/ src/
RUN --mount=type=cache,target=/root/.m2 ./mvnw package -DskipTests -q
RUN java -Djarmode=layertools -jar target/*.jar extract --destination target/extracted

FROM eclipse-temurin:21-jre-alpine AS runtime
RUN addgroup -S cinetrack && adduser -S cinetrack -G cinetrack
USER cinetrack:cinetrack
WORKDIR /app
COPY --from=builder --chown=cinetrack:cinetrack /app/target/extracted/dependencies/ ./
COPY --from=builder --chown=cinetrack:cinetrack /app/target/extracted/spring-boot-loader/ ./
COPY --from=builder --chown=cinetrack:cinetrack /app/target/extracted/snapshot-dependencies/ ./
COPY --from=builder --chown=cinetrack:cinetrack /app/target/extracted/application/ ./
EXPOSE 8080
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "org.springframework.boot.loader.launch.JarLauncher"]
