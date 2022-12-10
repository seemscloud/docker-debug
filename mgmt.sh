#!/bin/bash

PWD_PATH="$(pwd)"
SCRIPT_DIR="$(dirname "${0}")"
BUILD_DIR="docker"
PROJECT_PATH="${PWD_PATH}/${SCRIPT_DIR}"

DOCKER_REGISTRY="seemscloud"
DOCKER_REPO="network-debugging"
DOCKER_TAG="latest"

REPOSITORY="${DOCKER_REGISTRY}/${DOCKER_REPO}:${DOCKER_TAG}"

function mgmt() {
  case "${1}" in
  build)
    docker build \
      --rm --force-rm --pull --no-cache \
      --tag "${REPOSITORY}" \
      "${PROJECT_PATH}/${BUILD_DIR}"
    ;;
  push)
    docker push "${REPOSITORY}"
    ;;
  run)
    docker run \
      --detach \
      --interactive --rm \
      --name "${DOCKER_REPO}" \
      "${REPOSITORY}"
    ;;
  rm)
    docker container rm \
      --force \
      "${DOCKER_REPO}"
    ;;
  sh)
    docker exec -it \
      ${DOCKER_REPO} sh
    ;;
  esac
}

mgmt "${1}"
