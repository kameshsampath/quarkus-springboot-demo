#! /usr/bin/env bash

set -euxo pipefail

drone secret add --name maven_mirror_url --data 'http://nexus.infra:8081/repository/maven-public/' "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name destination_image --data "${REGISTRY_NAME}:${REGISTRY_PORT}/example/quarkus-springboot-demo" "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name image_registry --data "${REGISTRY_NAME}:${REGISTRY_PORT}" "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name image_registry_user --data "${IMAGE_REGISTRY_USER}" "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret add --name image_registry_password --data "${IMAGE_REGISTRY_PASSWORD}" "${GITEA_USERNAME}/quarkus-springboot-demo"