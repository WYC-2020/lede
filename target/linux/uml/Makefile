# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2006-2011 OpenWrt.org

include $(TOPDIR)/rules.mk

ARCH:=i386
BOARD:=uml
BOARDNAME:=User Mode Linux
FEATURES:=squashfs ext4 audio source-only
SUBTARGETS:=generic 64

KERNEL_PATCHVER:=6.6
KERNEL_TESTING_PATCHVER:=5.10

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += wpad-basic-wolfssl kmod-mac80211-hwsim mkf2fs e2fsprogs

$(eval $(call BuildTarget))
