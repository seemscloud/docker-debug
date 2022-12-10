#!/bin/bash

PWD_PATH="$(pwd)"
SCRIPT_DIR="$(dirname "${0}")"
BUILD_DIR="docker"
PROJECT_PATH="${PWD_PATH}/${SCRIPT_DIR}"

REPOSITORY="$(cat "${PROJECT_PATH}/REPOSITORY")"

docker build \
  --rm --force-rm \
  --pull --no-cache \
  --tag "${REPOSITORY}" "${PROJECT_PATH}/${BUILD_DIR}"
