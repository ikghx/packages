#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=yaaw
PKG_VERSION:=20231217
PKG_RELEASE:=1
PKG_MAINTAINER:=Hsing-Wang Liao <kuoruan@gmail.com>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/aa65535/yaaw-zh-hans.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=502914c66ffccec68f9d510973ea156055d9ad6c
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MIRROR_HASH:=e3862e6947ef8be7d1c831e796476c34025527cd396048071c43bc45d5458d97

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
