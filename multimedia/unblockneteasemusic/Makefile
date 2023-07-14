# SPDX-Identifier-License: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=unblockneteasemusic
PKG_BASE_VERSION:=0.27.2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/UnblockNeteaseMusic/server.git
PKG_SOURCE_DATE:=2023-07-11
PKG_SOURCE_VERSION:=3735929bf9f3998971f8e23a83358da63f97d1bd
PKG_MIRROR_HASH:=7d00eb3d2c704ed98045acca4c50fa1cb79fef40223927b742c59e5752abd9af

PKG_VERSION:=$(PKG_BASE_VERSION)-$(PKG_SOURCE_DATE)-$(call version_abbrev,$(PKG_SOURCE_VERSION))

PKG_LICENSE:=LGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Tianling Shen <cnsztl@immortalwrt.org>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Revive Netease Cloud Music (NodeJS)
  URL:=https://github.com/nondanee/UnblockNeteaseMusic
  DEPENDS:=+node
  PKGARCH:=all
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	xzcat $(DL_DIR)/$(PKG_SOURCE) | $(TAR) -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
endef

define Build/Configure
	echo -e $(PKG_BASE_VERSION) > $(PKG_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/core_ver
	echo -e $(PKG_SOURCE_VERSION) > $(PKG_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/local_ver
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/unblockneteasemusic/core
	$(CP) $(PKG_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/* $(1)/usr/share/unblockneteasemusic/core
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
