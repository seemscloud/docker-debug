#!/bin/bash

BASE_DIR="$(pwd)/$(dirname "${0}")"
IMAGE_REGISTRY="${1}"
IMAGE_TAG="${2}"
IMAGE_NAME="${3}"
COMMAND="${4}"

REPOSITORY="${IMAGE_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"

function get(){
  echo $(docker ps -f name="${IMAGE_NAME}" --format=json | jq -r ".ID" 2>&1)
}

function kill(){
  while true ; do
    CONTAINER_ID="$(get)"

    if [ "${CONTAINER_ID}" ] ; then
      docker kill "${CONTAINER_ID}" --signal SIGKILL > /dev/null 2>&1
    else
      break
    fi
  done
}

function build() {
    docker build --rm --force-rm --pull --no-cache --tag "${REPOSITORY}" "${BASE_DIR}/${IMAGE_NAME}"
}

function start(){
  docker run --detach --interactive --rm --name "${IMAGE_NAME}" "${REPOSITORY}" > /dev/null 2>&1
  docker exec -it "${IMAGE_NAME}" bash
}

function push(){
  docker push "${REPOSITORY}"
}

function cleanup(){
  docker container prune -f
  docker image prune -f
  docker system prune -f
}

case "${COMMAND}" in
  b)
    build
  ;;
  t)
    start
    kill
  ;;
  p)
    push
  ;;
  c)
    cleanup
  ;;
esac