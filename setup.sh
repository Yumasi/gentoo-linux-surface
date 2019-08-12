#!/usr/bin/env bash

set -e

# Options
NO_BUILD=0
NO_EMERGE=0
WITH_CONFIG=0

# Config
CONFIG_FILE='config-4.19.57-gentoo'
KERNEL_NAME='sys-kernel/gentoo-sources'
KERNEL_PATH='/usr/src/linux'
MAKEFLAGS='-j5'
PATCHES_DESTINATION="/etc/portage/patches/$KERNEL_NAME"

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

print_help() {
    echo 'Available options:'
    echo '--with-config: install provided configuration. Off by default.'
    echo '--no-emerge: skip installation of patches and emerging of kernel'
    echo '             sources. Off by default.'
    echo '--no-build: skip kernel building. Off by default.'
    echo '-h: displays this help page.'
}

while [ "$#" -ne 0 ]; do
    case "$1" in
         '--with-config')
             WITH_CONFIG=1
             ;;
         '--no-emerge')
             NO_EMERGE=1
             ;;
         '--no-build')
             NO_BUILD=1
             ;;
         '-h')
             print_help
             exit 0
             ;;
        *)
          echo "Unrecognized option: $1"
          exit 2
    esac

    shift
done

if [ "$NO_EMERGE" -eq 0 ]; then
    mkdir -pv "$PATCHES_DESTINATION"
    cp -v "$PWD"/patches/* "$PATCHES_DESTINATION"
    emerge -av "$KERNEL_NAME"
fi

if [ "$WITH_CONFIG" -ne 0 ]; then
    cp -v "$PWD"/configs/"$CONFIG_FILE" "$KERNEL_PATH"/.config
    make -C "$KERNEL_PATH" olddefconfig
fi

if [ "$NO_BUILD" -eq 0 ]; then
    make -C "$KERNEL_PATH" "$MAKEFLAGS"
    make -C "$KERNEL_PATH" modules_install
    make -C "$KERNEL_PATH" install
    emerge -1v @module-rebuild
fi
