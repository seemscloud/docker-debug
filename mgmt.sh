#!/bin/bash

PWD_PATH="$(pwd)"
SCRIPT_DIR="$(dirname "${0}")"
BUILD_DIR="docker"
PROJECT_PATH="${PWD_PATH}/${SCRIPT_DIR}"

DOCKER_REGISTRY="seemscloud"
DOCKER_REPO="debug"
DOCKER_TAG="latest"

REPOSITORY="${DOCKER_REGISTRY}/${DOCKER_REPO}:${DOCKER_TAG}"

function mgmt() {
  case "${1}" in
  build)
    docker build --rm --force-rm --pull --no-cache --tag "${REPOSITORY}" "${PROJECT_PATH}/${BUILD_DIR}"
    ;;
  cache)
    docker build --rm --force-rm --pull --tag "${REPOSITORY}" "${PROJECT_PATH}/${BUILD_DIR}"
    ;;
  test)
    mgmt rm container
    docker run --detach --interactive --rm --name "${DOCKER_REPO}" "${REPOSITORY}"
    docker exec -it ${DOCKER_REPO} bash
    ;;
  rm)
    mgmt rm-container
    docker image rm "${REPOSITORY}"
    ;;
  rm-container)
    docker container rm --force "${DOCKER_REPO}"
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

mgmt "${1}" "${2}"
