#!/bin/bash
#
# This script builds OAI NR UE and gNB locally on the system.
# For more information, see ./doc/BUILD.md (locally) or https://gitlab.eurecom.fr/oai/openairinterface5g/-/blob/develop/doc/BUILD.md (online).
#
# IMPORTANT: Not all distributions are supported by OAI (see ./cmake_targets/build_oai and ./cmake_targets/tools/build_helper).
# If your distribution is not supported, consider using the ./build_oai_docker.sh script instead.
# Even if you manually install all packages and dependencies, the build process can fail due to e.g. wrong gcc version or for whatever reason.

set -euo pipefail
IFS=$'\n\t'

umask 077


export BUILD_UHD_FROM_SOURCE=True
export UHD_VERSION=4.8.0.0

# Prepare the environment
/bin/sh oaienv
cd cmake_targets
mkdir -p log

# Install and build the dependencies
# The build_oai script *should* handle missing dependencies
# If it does not, just install the missing package(s)
./build_oai -I -w USRP --install-optional-packages

# Build the OAI executables (NR UE and gNB)
./build_oai -c --ninja \
    --nrUE --gNB \
    -w USRP -t Ethernet \
    --noavx512 \
    --build-tool-opt -k10 \
    --cmake-opt -DCMAKE_C_FLAGS="-Werror" --cmake-opt -DCMAKE_CXX_FLAGS="-Werror"
