# Java CI with Drone

The demo application that can be used to demonstrate on how to do CI with Java Applications with Drone CI. This project plays well with used with [Java GitOps Demo with Argo CD](https://github.com/kameshsampath/quarkus-springboot-demo-gitops).

## Prerequisites

- [Docker for Mac/Windows/Linux](https://www.docker.com/products/docker-desktop)
- [httpie](https://httpie.org/)
- [Drone CLI](https://docs.drone.io/cli/install/)

## Setup DAG Stack

You need a environment that can help you do CI and GitOps. You can setup one locally as described here <https://github.com/kameshsampath/dag-stack.git>.

## Drone Configuration

Copy Account settings from Drone,

```shell
export DRONE_SERVER=http://drone-127.0.0.1.sslip.io:30980
export DRONE_TOKEN=<some token value>
export REGISTRY_NAME=nexus.infra
# always 18081 for in cluster push and pull
export REGISTRY_PORT=18081
export IMAGE_REGISTRY_USER=admin
export IMAGE_REGISTRY_PASSWORD=admin123
export GITEA_USERNAME=user-01
```

Ensure the token works,

```shell
drone info
```

__IMPORTANT__: Activate the `quarkus-springboot-demo` project on Drone.

### Add Secrets to Repository

```shell
drone secret add --name maven_mirror_url --data 'http://nexus.infra:8081/repository/maven-public/' "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name destination_image --data "${REGISTRY_NAME}:${REGISTRY_PORT}/example/quarkus-springboot-demo" "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name image_registry --data "${REGISTRY_NAME}:${REGISTRY_PORT}" "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name image_registry_user --data "${IMAGE_REGISTRY_USER}" "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name image_registry_password --data "${IMAGE_REGISTRY_PASSWORD}" "${GITEA_USERNAME}/quarkus-springboot-demo"
```

## Testing with Kubernetes

To test the application with Kubernetes use the <https://github.com/kameshsampath/dag-stack>, that will rely use GitOps Principles to deploy the application

## Testing the application Locally

## Run Locally

Start the Database:

```shell
docker-compose up 
```

### Spring Boot

NOTE: For local run, update the src/main/resources/applicaiton.properties to make sure the Postgesql url is `jdbc:postgresql://localhost:5432/demodb`

```shell
mvn clean package
java -jar target/fruits-app.jar
```

### Quarkus Spring Boot

Checkout to quarkus branch:

```shell
git checkout db-quarkus
```

#### JVM mode

```shell
mvn clean package
java -jar target/quarkus-app/quarkus-run.jar
```

#### Native mode

```shell
mvn package -Pnative
./target/fruits-app
```


```shell
docker-compose up -d 
```

Now open the url <http://localhost:8080/api/all> to see the list of fruits.

Test adding a fruit:

```shell
http localhost:8080/api/add name=jackfruit season=summer
```

You can check the list of fruits again using <http://localhost:8080/api/all>.
.
