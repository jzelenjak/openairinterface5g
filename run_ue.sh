#!/bin/bash
#
# This script is a shortcut to start the software modem for OAI NR UE.
# NOTE: For information about the required capabilities to run the nr-uesoftmodem, see ./doc/tuning_and_security.md

set -euo pipefail
IFS=$'\n\t'

umask 077


# Command line parameters for OAI NR UE can also be found in the gNB(-DU) logs
# NOTE: To run the RF simulator, add the following arguments to the command: --rfsim --rfsimulator.serveraddr 192.168.80.129
# NOTE: To use USRP, add the following argument to the command: --usrp-args "serial=......." (use uhd_find_devices to find the serial number)
# NOTE: To increment IMSI (MSIN) for each new NAS Registration Request, add the following argument to the command: --uicc0.inc_imsi 1
./cmake_targets/ran_build/build/nr-uesoftmodem -C 3619200000 -r 106 --numerology 1 --band 78 --ssb 516 -E --ue-fo-compensation --uicc0.imsi 001010000000001

# Below are some options for logging (useful for debugging)
# --log_config.global_log_level info
# --log_config.global_log_options level,thread,function
# --log_config.nr_rrc_log_level debug
# --log_config.pdcp_log_level debug
# --log_config.rlc_log_level debug
# --log_config.nr_mac_log_level info
# --log_config.nr_mac_dci_log_level error
# --log_config.nr_phy_dci_log_level error
# --log_config.nr_phy_log_level error
# --log_config.hw_log_level error
# --log_config.util_log_level error

# To check all options, enter an invalid one, e.g.:
# --log_config.NRRRC_debug

# For more information on configuring log levels, see:
# https://github.com/OPENAIRINTERFACE/openairinterface5g/blob/develop/common/utils/LOG/DOC/rtusage.md
