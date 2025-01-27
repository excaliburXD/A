#
# Copyright (C) 2023 The OrangeFox Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from x695c device
$(call inherit-product, device/infinix/x695c/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := x695c
PRODUCT_NAME := twrp_x695c
PRODUCT_BRAND := infinix
PRODUCT_MANUFACTURER := infinix
