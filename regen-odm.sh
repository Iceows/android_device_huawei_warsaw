#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
# Usage ./regen-odm.sh odm-raw.img odm-prop.txt
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

_input_image="${1}"
_output_file="${2}"

if [ -z "${_input_image}" ]; then
    echo "No input image supplied"
    exit 1
fi

if [ -z "${_output_file}" ]; then
    echo "No output filename supplied"
    exit 1
fi

VENDOR_SKIP_FILES=(
    # Standard build output with vendor image build enabled

    # Test mapping
    "firmware/TEST_MAPPING"
)

# Initialize the helper
setup_vendor_deps "${ANDROID_ROOT}"

generate_prop_list_from_image "${_input_image}" "${_output_file}" VENDOR_SKIP_FILES

# Fixups
function presign() {
    sed -i "s|odm/${1}$|odm/${1};PRESIGNED|g" "${_output_file}"
}

function as_module() {
    sed -i "s|odm/${1}$|-odm/${1}|g" "${_output_file}"
}

function header() {
    sed -i "1s/^/${1}\n/" "${_output_file}"
}

as_module "lib/libbtnv.so"
as_module "lib/libMpeg4SwEncoder.so"
as_module "lib/libsdsprpc.so"
as_module "lib64/libbtnv.so"
as_module "lib64/libMpeg4SwEncoder.so"
as_module "lib64/libsdsprpc.so"

header "# All blobs are extracted from Huawei factory images"

