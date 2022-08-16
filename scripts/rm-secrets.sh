#! /usr/bin/env bash

set -euxo pipefail

drone secret rm --name maven_mirror_url "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret rm --name destination_image "${GITEA_USERNAME}/quarkus-springboot-demo"

drone secret rm --name image_registry

drone secret rm --name image_registry_user

drone secret update --name image_registry_password