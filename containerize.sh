#!/usr/bin/env bash
set -Eeuo pipefail

: "${GITHUB_SHA?'Expected env var GITHUB_SHA not set'}"
: "${GITHUB_REF_TYPE?'Expected env var GITHUB_REF_TYPE not set'}"
: "${GITHUB_REF_NAME?'Expected env var GITHUB_REF not set'}"
: "${DOCKER_REGISTRY_HOST?'Expected env var DOCKER_REGISTRY_HOST not set'}"
: "${DOCKER_IMAGE_NAME?'Expected env var DOCKER_IMAGE_NAME not set'}"
: "${CONTAINER_PORTS:=8080}"
: "${DOCKER_PUSH:=true}"


# This function replaces all characters in the input to that a valid docker tag is created
function create_valid_docker_tag_name {
  # tr '[:upper:]' '[:lower:]' --> Replace all upper characters with lower characters
  # tr -cs '[:alnum:]' '-' --> Replace all special characters (all non alpha-numeric characters) with a single minus
  # sed 's/^-*//' --> Delete a "-" at the beginning of the string
  # sed 's/-*$//' --> Delete a "-" at the end of the string
  REF=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]' '-' | sed 's/^-*//' | sed 's/-*$//')

  now=$(date +"%s")
  # If it's a branch append the commit sha
  if [[ "$2" == "branch" ]]; then
    REF="$REF-$now$3"
  fi

  # limit branch name lengths to 128 characters as docker tags are max 128 characters
  if [ ${#REF} -gt 128 ]; then
    # first char of last 128 chars might be a '-' again. if so, strip it.
    # shellcheck disable=SC2001
    REF=$(echo "${REF: -128}" | sed 's/^-*//')

  fi
  echo "$REF"
}

function containerize() {

    echo "::group:: Preparing image build for ${DOCKER_IMAGE_NAME}"
    echo "Setting required env vars and substituting."
     now=$(date +"%s")
    echo "REF=${GITHUB_REF_NAME}"
    echo "REF_TYPE=${GITHUB_REF_TYPE}"
    echo "SHA=${GITHUB_SHA}"
    echo "time=${now}"

    DOCKER_IMAGE_TAG=$(create_valid_docker_tag_name "${DOCKER_IMAGE_PREFIX}-${GITHUB_REF_NAME}" "${GITHUB_REF_TYPE}" "${GITHUB_SHA}")
    IMAGE_NAME="${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"

    echo "Building imageName  ${IMAGE_NAME} "
    echo "imageName=$IMAGE_NAME" >> "$GITHUB_OUTPUT"

    echo "imageTagName  ${DOCKER_IMAGE_TAG}"
    echo "imageTagName=$DOCKER_IMAGE_TAG" >> "$GITHUB_OUTPUT"

    echo "::endgroup::"
}

containerize
