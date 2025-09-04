FROM gradle:8.10.2-jdk21-alpine AS builder

WORKDIR /app

# Copy gradle wrapper files first
COPY gradle/ gradle/
COPY gradlew gradlew.bat ./
COPY settings.gradle build.gradle ./

# Copy source code
COPY src/ src/
COPY config/ config/

RUN chmod +x ./gradlew && ./gradlew shadowJar --no-daemon

FROM alpine:latest AS extractor
WORKDIR /output
COPY --from=builder /app/build/libs/*.jar ./
RUN ls -la && mv *.jar plugin.jar