#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Allow building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

DEVICE_PATH := device/infinix/X695C
PREBUILT_PATH := $(DEVICE_PATH)/prebuilt

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mt6785
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := mt6785

# Assert
TARGET_OTA_ASSERT_DEVICE := X695C

# Kernel
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_BASE := 0x40078000           
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
TARGET_KERNEL_COMPRESSION := lzma # (more efficient than gzip or lz4, but takes more time during boot)

BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_BOOT_HEADER_VERSION := 2
BOARD_RAMDISK_USE_LZ4 := true # (Ramdisk Compression)

BOARD_MKBOOTIMG_ARGS += \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
    --header_version $(BOARD_BOOT_HEADER_VERSION) \
    --dtb $(TARGET_PREBUILT_DTB)

# AVB - Android Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# System as Root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Partitions Config
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
BOARD_USES_METADATA_PARTITION := true
STRIP_MODULES := true # (Debug Symbols binary)

# Partitions Size
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432

# Dynamic Partitions
BOARD_SUPER_PARTITION_SIZE := 7395069944
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 7395069944
BOARD_MAIN_PARTITION_LIST := \
      system \
      vendor \
      product \
      system_ext

# Files System
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_F2FS := true

# AB
AB_OTA_UPDATER := true

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster41 \
    libpuresoftkeymasterdevice

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

## TWRP-Specific configuration

TW_THEME := portrait_hdpi
TW_DEVICE_VERSION := Prebuilt-A12-X695C-By_Gilanggegea
TW_DEFAULT_LANGUAGE := en
TW_INCLUDE_NTFS_3G := false
TW_INCLUDE_REPACKTOOLS := false
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_INCLUDE_FASTBOOTD := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_BASH := true

# Device config
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_FRAMERATE := 60
TW_SCREEN_BLANK_ON_BOOT := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

# Decryption
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster41.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so

# StatusBar
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CPU_POS := "300"
TW_CUSTOM_CLOCK_POS := "70"
TW_CUSTOM_BATTERY_POS := "790"
