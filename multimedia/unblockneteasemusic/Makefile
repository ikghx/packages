# SPDX-Identifier-License: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=unblockneteasemusic
PKG_BASE_VERSION:=0.27.8
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/UnblockNeteaseMusic/server.git
PKG_SOURCE_DATE:=2024-11-05
PKG_SOURCE_VERSION:=f50ea140d454e93bd5e7efe97e3ee0bc0a02d8de
PKG_MIRROR_HASH:=4b177f42e038a21fe9e1067aad08b3fe3bfcea7272938304f53e37639d117fd8

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
