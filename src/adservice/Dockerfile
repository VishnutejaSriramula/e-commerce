FROM eclipse-temurin:8u472-b08-jdk-ubi10-minimal AS builder
LABEL stage="builder"
WORKDIR /usr/local/app
COPY gradlew settings.gradlew build.gradle ./
COPY gradle/ ./
RUN ./gradlew downloadRepos
COPY . .
RUN ./gradlew installDist

FROM eclipse-temurin:8u472-b08-jre-ubi10-minimal
LABEL app="ad-service" project="e-commerce"
WORKDIR /usr/local/app
COPY --from=builder /usr/local/app/build/install/hipstershop/bin/AdService ./
RUN useradd -r -u 10001 aduser
RUN chown -R aduser:aduser /usr/local/app
USER aduser
EXPOSE 8080
ENTRYPOINT ["./AdService"]