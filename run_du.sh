#!/bin/bash
#
# This script is a shortcut to start the software modem for OAI gNB-DU.
# NOTE: Check that the IP addresses in the configuration file are correct.
# NOTE: For information about the required capabilities to run the nr-softmodem, see ./doc/tuning_and_security.md

set -euo pipefail
IFS=$'\n\t'

umask 077


CONFIG_FILE="./targets/PROJECTS/GENERIC-NR-5GC/CONF/gnb-du.sa.band78.106prb.rfsim.conf"

# NOTE: To run the RF simulator, add the following arguments to the command: --rfsim --rfsimulator.serveraddr server
# NOTE: To use USRP, add the following line to the configuration file to the "RUs" section:
#   sdr_addrs = "serial=.......";
# (Use uhd_find_devices to find the serial number)
./cmake_targets/ran_build/build/nr-softmodem -O "$CONFIG_FILE" --gNBs.[0].min_rxtxtime 6 -E --disable-stats
