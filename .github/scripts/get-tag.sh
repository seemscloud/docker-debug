#!/bin/bash

git fetch --tags

LATEST_TAG=$(git tag --sort=committerdate  | grep -Ei "^[a-z0-9]{3,}-v[0-9]+.[0-9]+.[0-9]+$" | grep -Ei "^${1}-v" | tail -1)

if [ -z "${LATEST_TAG}" ] ; then
  echo "Failed on tag match.."
  exit 100
fi

echo ::set-output name=LATEST_TAG::"${LATEST_TAG}"

echo "${LATEST_TAG}"