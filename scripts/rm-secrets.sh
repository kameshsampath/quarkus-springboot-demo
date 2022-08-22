#! /usr/bin/env bash

set -euxo pipefail

drone secret rm --name maven_mirror_url "${QSBD_GIT_REPO}"

drone secret rm --name destination_image "${QSBD_GIT_REPO}"

drone secret rm --name image_registry "${QSBD_GIT_REPO}"

drone secret rm --name image_registry_user "${QSBD_GIT_REPO}"

drone secret update --name image_registry_password "${QSBD_GIT_REPO}"