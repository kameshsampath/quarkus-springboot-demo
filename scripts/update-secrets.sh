#! /usr/bin/env bash

set -euxo pipefail

drone secret update --name maven_mirror_url --data 'http://nexus.infra:8081/repository/maven-public/' "${QSBD_GIT_REPO}"

drone secret update --name destination_image --data "${REGISTRY_NAME}/example/quarkus-springboot-demo" "${QSBD_GIT_REPO}"

drone secret update --name image_registry --data "${REGISTRY_NAME}" "${QSBD_GIT_REPO}"

drone secret update --name image_registry_user --data "${IMAGE_REGISTRY_USER}" "${QSBD_GIT_REPO}"

drone secret update --name image_registry_password --data "${IMAGE_REGISTRY_PASSWORD}" "${QSBD_GIT_REPO}"