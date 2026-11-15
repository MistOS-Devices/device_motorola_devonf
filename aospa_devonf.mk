#
# Copyright (C) 2024-2026 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/motorola/devonf/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_NAME := aospa_devonf
PRODUCT_DEVICE := devonf
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g73 5G

PRODUCT_GMS_CLIENTID_BASE := android-motorola
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=devonf \
    BuildDesc="devonf_g_sys-user 14 U1TNS34.82-12-7-25 86c959-5b006d release-keys" \
    BuildFingerprint=motorola/devonf_g_sys/devonf:14/U1TNS34.82-12-7-25/86c959-5b006d:user/release-keys
