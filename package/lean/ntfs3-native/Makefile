#
# Copyright (c) 2013-2018, 2020 The Linux Foundation. All rights reserved.
# Permission to use, copy, modify, and/or distribute this software for
# any purpose with or without fee is hereby granted, provided that the
# above copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
# OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ntfs3-native
PKG_VERSION:=2022-08-03
PKG_RELEASE:=2

include $(INCLUDE_DIR)/package.mk

define KernelPackage/ntfs3-native
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Filesystems
  DEPENDS:=+kmod-nls-utf8
  TITLE:=Fully functional NTFS Read-Write driver
  FILES:= $(PKG_BUILD_DIR)/ntfs3.ko
  PROVIDES:=$(PKG_NAME)
endef

define KernelPackage/ntfs3-native/Description
  This package provides the kernel module for ntfs3.
endef

define Build/Compile
	$(KERNEL_MAKE) M="$(PKG_BUILD_DIR)" \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	$(PKG_EXTRA_KCONFIG) \
	CONFIG_NTFS3_FS=m \
	modules
endef

$(eval $(call KernelPackage,ntfs3-native))
