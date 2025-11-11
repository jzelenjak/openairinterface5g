#!/bin/bash
#
# This script is a shortcut to start the software modem for OAI gNB-CU.
# NOTE: Check that the IP addresses in the configuration file are correct.
# NOTE: For information about the required capabilities to run the nr-softmodem, see ./doc/tuning_and_security.md

set -euo pipefail
IFS=$'\n\t'

umask 077


CONFIG_FILE="./targets/PROJECTS/GENERIC-NR-5GC/CONF/gnb-cu.sa.f1.conf"

./cmake_targets/ran_build/build/nr-softmodem -O "$CONFIG_FILE" --disable-stats
