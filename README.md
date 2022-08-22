# Java CI with Drone

The demo application that can be used to demonstrate on how to do CI with Java Applications with Drone CI. This project plays well with used with [Java GitOps Demo with Argo CD](https://github.com/kameshsampath/quarkus-springboot-demo-gitops).

## Prerequisites

- [Docker for Mac/Windows/Linux](https://www.docker.com/products/docker-desktop)
- [httpie](https://httpie.org/)
- [Drone CLI](https://docs.drone.io/cli/install/)

## Setup DAG Stack

You need a environment that can help you do CI and GitOps. You can setup one locally as described here <https://github.com/kameshsampath/dag-stack.git>.

## Drone Configuration

Switch to tab **Terminal 2**,

Copy Account settings from Drone Account settings page, then create a new file called `.envrc.local` and add the variables to override,

```shell
export DRONE_SERVER="http://kubernetes-vm.${_SANDBOX_ID}.sslip.io:30980"
export DRONE_TOKEN="drone token from the drone account settings page"
```

Ensure the token works,

```shell
drone info
```

Now activate the `quarkus-springboot-demo` in Drone,

```shell
drone repo activate "${QUARKUS_SPRINGBOOT_DEMO_GIT_REPO}"
```

### Add Secrets to Drone Repository

The application build uses few secrets namely,

- `maven_mirror_url` : The maven mirror to used by Apache Maven builder to download the artifacts.
- `destination_image`: The container image name. Default to `${REGISTRY_NAME}/example/quarkus-springboot-demo`.
- `image_registry`: The Image registry to use. Derived from environment variable `${REGISTRY_NAME}`.
- `image_registry_user`: The Image registry username to authenticate. Defaults `admin`.
- `image_registry_password`: The Image registry user password to be used while authentication authenticate. Defaults to `admin123`.

Run the following script to add the secrets to the Drone repo `${QUARKUS_SPRINGBOOT_DEMO_GIT_REPO}`,

```shell
./scripts/add-secrets.sh
```

### Updating Secrets

```shell
./scripts/update-secrets.sh
```

### Remove Secrets

```shell
./scripts/rm-secrets.sh
```

## Testing with Kubernetes

To test the application with Kubernetes use the <https://github.com/kameshsampath/dag-stack>, that will rely use GitOps principles to deploy the application.

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
