#!/bin/bash

PROJECT_PATH="$(pwd)/$(dirname "${0}")"
BUILD_DIR="${2}"

DOCKER_REGISTRY="seemscloud"
DOCKER_TAG="latest"

REPOSITORY="${DOCKER_REGISTRY}/${BUILD_DIR}:${DOCKER_TAG}"

function mgmt() {
  case "${1}" in
  build)
    docker build --rm --force-rm --pull --no-cache --tag "${REPOSITORY}" "${PROJECT_PATH}/${BUILD_DIR}"
    ;;
  cache)
    docker build --rm --force-rm --pull --tag "${REPOSITORY}" "${PROJECT_PATH}/${BUILD_DIR}"
    ;;
  test)
    mgmt rm-container
    docker run --detach --interactive --rm --name "${BUILD_DIR}" "${REPOSITORY}"
    docker exec -it "${BUILD_DIR}" bash
    ;;
  rm)
    mgmt rm-container
    docker image rm "${REPOSITORY}"
    ;;
  rm-container)
    docker container rm --force "${BUILD_DIR}"
    ;;
  push)
    mgmt build
    docker push "${REPOSITORY}"
    ;;
  prune)
    docker container prune -f
    docker image prune -f
    docker system prune -f
    ;;
  esac
}

mgmt "${1}" "${BUILD_DIR}"
