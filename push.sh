#!/bin/bash

PWD_PATH="$(pwd)"
SCRIPT_DIR="$(dirname "${0}")"
PROJECT_PATH="${PWD_PATH}/${SCRIPT_DIR}"

REPOSITORY="$(cat "${PROJECT_PATH}/REPOSITORY")"

docker push "${REPOSITORY}"
