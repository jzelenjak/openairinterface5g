#!/bin/bash
#
# This script builds OAI NR UE and gNB images based on the local source code.

set -euo pipefail
IFS=$'\n\t'

umask 077


# Friendly reminder: When updating these image names, don't forget to update the Dockerfile that depends on that image
DEPS_IMAGE_NAME="oai-deps"
BUILDER_IMAGE_NAME="oai-builder"
UE_IMAGE_NAME="rogue-oai-ue"
GNB_IMAGE_NAME="rogue-oai-gnodeb"

# NOTE: To compile UE and gNB into separate images, use Dockerfile.build and the corresponding Dockerfiles
# (This is the recommended way for development, since all dependencies will have to be compiled only once)
docker build -t "$DEPS_IMAGE_NAME" --file ./Dockerfile.deps .
docker build -t "$BUILDER_IMAGE_NAME" --file ./Dockerfile.build .
docker build -t "$UE_IMAGE_NAME" --file ./Dockerfile.nrUE .
docker build -t "$GNB_IMAGE_NAME" --file ./Dockerfile.gNB .

# NOTE: To compile UE and gNB into a single image (using one Dockerfile), use Dockerfile.all
# (This is not recommended for development, since all dependencies will have to be compiled every time)
# docker build -t rogue-oai-all --file ./Dockerfile.all .

# NOTE: To compile UE and gNB into separate images using the Dockerfiles from the official OAI repository, use docker/ directory
# NOTE: If the build fails, you might need to comment out the E2 (flexric) part from the Dockerfiles. Specifically:
#   - In ./docker/Dockerfile.build.ubuntu: comment out the line `--build-e2 --cmake-opt -DKPM_VERSION=$KPM_VERSION --cmake-opt -DE2AP_VERSION=$E2AP_VERSION`
#   - In ./docker/Dockerfile.gNB.ubuntu: comment out the line `COPY --from=gnb-build /usr/local/lib/flexric /usr/local/lib/flexric`
# docker build -t ran-base --file ./docker/Dockerfile.base.ubuntu --build-arg TARGETARCH=amd64 .
# docker build -t ran-build --file ./docker/Dockerfile.build.ubuntu .
# docker build -t "$UE_IMAGE_NAME" --file ./docker/Dockerfile.nrUE.ubuntu --build-arg TARGETPLATFORM="linux/amd64" .
# docker build -t "$GNB_IMAGE_NAME" --file ./docker/Dockerfile.gNB.ubuntu --build-arg TARGETPLATFORM="linux/amd64" .
