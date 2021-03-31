#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#
# licheng
# www.maxlicheng.com
# 2019-07-28
#

include $(TOPDIR)/rules.mk

PKG_NAME:=unblockneteasemusic
PKG_VERSION:=0.25.3
PKG_RELEASE:=4

PKG_LICENSE:=MIT

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nondanee/UnblockNeteaseMusic.git
PKG_SOURCE_VERSION:=b8d5f4b4fe59cef9c021b99f3cf2606d99fa4790
PKG_MIRROR_HASH:=a72a158f683ffecedb813a419612a916de02040c6e61ab93c1fc5738300fbf8f

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR)-$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Revive Netease Cloud Music (NodeJS)
	DEPENDS:=+node
	URL:=https://github.com/nondanee/UnblockNeteaseMusic/releases
	SUBMENU:=NeteaseMusic
	PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
Revive Netease Cloud Music (NodeJS)
endef

define Build/Prepare
	tar -xzvf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR)  $(1)/usr/share/$(PKG_NAME)/core
	cp -pR $(PKG_BUILD_DIR)/$(PKG_NAME)/* $(1)/usr/share/$(PKG_NAME)/core
	echo -e $(PKG_SOURCE_VERSION) > $(1)/usr/share/$(PKG_NAME)/core_local_ver
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
