#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from warsaw device
$(call inherit-product, device/huawei/warsaw/device.mk)

PRODUCT_DEVICE := warsaw
PRODUCT_NAME := lineage_warsaw
PRODUCT_BRAND := Huawei
PRODUCT_MODEL := WAS-LX1A
PRODUCT_MANUFACTURER := huawei

PRODUCT_GMS_CLIENTID_BASE := android-huawei
