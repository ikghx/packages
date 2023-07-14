#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=yaaw
PKG_VERSION:=2022-06-06
PKG_RELEASE:=1
PKG_MAINTAINER:=Hsing-Wang Liao <kuoruan@gmail.com>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/aa65535/yaaw-zh-hans.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=755304907d0fb8e65a06859bdb7264a5c09428bc
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MIRROR_HASH:=f2a7535cc812f8b971555d906594be2ca0de8d2ad03a584fd88d9e43ebc94aef

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
