#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=yaaw
PKG_VERSION:=2019-10-15
PKG_RELEASE:=1
PKG_MAINTAINER:=Hsing-Wang Liao <kuoruan@gmail.com>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/aa65535/yaaw-zh-hans.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=f47c148cb860b10f13eea059bf261e70842b3950
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MIRROR_HASH:=1e5d801528ebc15073d6e5358dec707361f42e5376b447db1951239abcf642ff

PKG_LICENSE:=LGPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/yaaw
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Download Manager
  DEPENDS:=
  TITLE:=Yet another aria2 web frontend
  URL:=https://github.com/binux/yaaw
  PKGARCH:=all
endef

define Package/yaaw/description
	Yet Another Aria2 Web Frontend in pure HTML/CSS/Javascirpt.
endef

define Build/Compile
endef

define Package/yaaw/install
	$(INSTALL_DIR) $(1)/www/yaaw
	$(CP) \
		$(PKG_BUILD_DIR)/{css,img,js} \
		$(1)/www/yaaw
	$(CP) \
		$(PKG_BUILD_DIR)/{index.html,offline.appcache,favicon.ico,usage.html} \
		$(1)/www/yaaw
endef

$(eval $(call BuildPackage,yaaw))
