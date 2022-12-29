#
# Copyright (C) 2011-2020 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=upx
PKG_VERSION:=4.0.1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-src.tar.xz
PKG_SOURCE_URL:=https://github.com/upx/upx/releases/download/v$(PKG_VERSION)
PKG_HASH:=77003c8e2e29aa9804e2fbaeb30f055903420b3e01d95eafe01aed957fb7e190

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-src
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-$(PKG_VERSION)-src

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

CMAKE_OPTIONS += -DCMAKE_BUILD_TYPE=Release

define Package/upx
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libucl +libstdcpp +zlib
  TITLE:=The Ultimate Packer for eXecutables
  URL:=https://upx.github.io/
endef

define Package/upx/description
UPX is a free, portable, extendable, high-performance executable packer for
several different executable formats. It achieves an excellent compression ratio
and offers very fast decompression. Your executables suffer no memory overhead
or other drawbacks for most of the formats supported, because of in-place
decompression.
endef

define Package/upx/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/release/upx $(1)/usr/bin/upx
endef

define Host/Install
	$(CP) $(HOST_BUILD_DIR)/build/release/upx $(STAGING_DIR_HOST)/bin/upx
endef

define Host/Clean
	rm -f $(STAGING_DIR_HOST)/bin/upx
endef

$(eval $(call BuildPackage,upx))
$(eval $(call HostBuild))