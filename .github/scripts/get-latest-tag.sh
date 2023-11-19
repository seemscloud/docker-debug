#!/bin/bash

git fetch --tags

LATEST_TAG=$(git tag --sort=committerdate  | grep -Ei "^v[0-9]+.[0-9]+.[0-9]+$" | tail -1)

if [ -z "${LATEST_TAG}" ] ; then
  echo "Failed on tag match.."
  exit 100
fi

echo ::set-output name=TAG::"${LATEST_TAG}"