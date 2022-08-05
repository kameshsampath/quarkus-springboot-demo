# Quarkus Spring Boot Demo

A simple CRUD application demonstration using vanilla SpringBoot and Quarkized Spring Boot.

## Prerequisites

- [Docker for Mac/Windows/Linux](https://www.docker.com/products/docker-desktop)
- [httpie](https://httpie.org/)
- [Drone CLI](https://docs.drone.io/cli/install/)

## Drone Configuration

Copy Account settings from Drone,

```shell
export DRONE_SERVER=http://drone-127.0.0.1.sslip.io:30980
export DRONE_TOKEN=<some token value>
```

Ensure the token works,

```shell
drone info
```

The command above should display the git(gitea) user and password

__IMPORTAN__: Activate the quarkus-springboot-demo project on Drone.

### Add Secrets to Repository

```shell
drone secret add --name maven_mirror_url --data 'http://nexus3.infra:8081/repository/maven-public/' user-01/quarkus-springboot-demo
drone secret add --name destination_image --data 'kind-registry:5000/example/quarkus-springboot-demo' user-01/quarkus-springboot-demo
```

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

## Testing the application Locally

```shell
docker-compose up -d 
```

Now open the url <http://localhost:8080/api/all> to see the list of fruits.

Test adding a fruit:

```shell
http localhost:8080/api/add name=jackfruit season=summer
```

You can check the list of fruits again using <http://localhost:8080/api/all>.

## Testing with Kubernetes

To test the application with Kubernetes use the <https://github.com/kameshsampath/dag-stack>, that will rely use GitOps Principles to deploy the application.
