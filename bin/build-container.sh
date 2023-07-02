#!/usr/bin/env bash
set -e

if [ $# -le 0 ]; then
    echo "usage: $0 [image_name] [image_tag=latest]"
    exit 1
fi

BUILD_PGM=${BUILD_PGM:-docker}
IMAGE_NAME="${1%%/}"
IMAGE_TAG="${2:-latest}"

cd ${IMAGE_NAME}

${BUILD_PGM} build \
        -t ${IMAGE_NAME}:${IMAGE_TAG} \
        .

