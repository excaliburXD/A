#!/usr/bin/env bash

#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

FDEVICE="X695C"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export ALLOW_MISSING_DEPENDENCIES=true
    export PLATFORM_VERSION_LAST_STABLE="$PLATFORM_VERSION"
    export PLATFORM_SECURITY_PATCH="2099-12-31"
    export TW_DEFAULT_LANGUAGE="en"
    export LC_ALL="C"

    # Partitions Recovery
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"

    # A/B and Dynamic Partitions Support
    export FOX_AB_SUPPORT=true
    export FOX_AB_DEVICE=1
    export OF_DYNAMIC_PARTITIONS=true
    export FOX_VIRTUAL_AB_DEVICE=1

    # OTA and Verity Support
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export OF_DISABLE_FORCED_ENCRYPTION=1
    export OF_DISABLE_DM_VERITY_FORCED_ENCRYPTION=1
 
    # AVB Support
    export OF_PATCH_AVB20=1

    # Magisk Support
    export OF_USE_MAGISKBOOT=1
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1

    # Screen Height
    export OF_SCREEN_H=2400
    export OF_STATUS_H=80
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_ALLOW_DISABLE_NAVBAR=1

    # Backup and File System Support
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
    export OF_USE_TAR_BINARY=1
    export OF_USE_SED_BINARY=1
    export OF_USE_XZ_UTILS=1

    # Additional Support 
    export OF_DEFAULT_KEYMASTER_VERSION="4.0"
    export FOX_EXTREME_SIZE_REDUCTION=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export FOX_DELETE_AROMAFM=1
    export OF_USE_GREEN_LED=0
    export FOX_ENABLE_APP_MANAGER=1
    export OF_ENABLE_LPTOOLS=1
    export OF_SKIP_DECRYPTED_ADOPTED_STORAGE=1
    export OF_SKIP_FBE_DECRYPTION_SDKVERSION=34 # Don't try to decrypt A14(?)
    export OF_ADVANCED_SECURITY=1
    export FOX_DELETE_INITD_ADDON=1
    export FOX_REMOVE_AAPT=1
   
    # run a process after formatting data to work-around MTP issues
    export OF_RUN_POST_FORMAT_PROCESS=1
    export OF_SKIP_ORANGEFOX_PROCESS=1
    
    # R11.1 Settings
    export FOX_VERSION="R11.0"
    export FOX_VARIANT="Prebuilt"
    export OF_MAINTAINER="Gilanggegea"
    export FOX_BUILD_DEVICE="Infinix Note 10 Pro"
    export FOX_BUILD_TYPE="A/B Devices"
    export TARGET_DEVICE_ALT="X695C,X695"

    # Use LZMA
    export OF_USE_LZMA_COMPRESSION=1

    # Log Build Variables
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> "$FOX_BUILD_LOG_FILE"
        export | grep "OF_" >> "$FOX_BUILD_LOG_FILE"
        export | grep "TARGET_" >> "$FOX_BUILD_LOG_FILE"
        export | grep "TW_" >> "$FOX_BUILD_LOG_FILE"
    fi
fi
