#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libid3tag
PKG_VERSION:=0.16.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeberg.org/tenacityteam/libid3tag/archive
PKG_HASH:=0561009778513a95d91dac33cee8418d6622f710450a7cb56a74636d53b588cb
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_LICENSE:=GPL-2
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:media-libs:libid3tag

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
CMAKE_BINARY_SUBDIR:=openwrt-build

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libid3tag
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+zlib
  TITLE:=An ID3 tag manipulation library
  URL:=https://codeberg.org/tenacityteam/libid3tag
endef

define Package/libid3tag/description
	libid3tag is a library for reading and (eventually) writing ID3 tags, both
	ID3v1 and the various versions of ID3v2.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/id3tag.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libid3tag.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/id3tag.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libid3tag/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libid3tag.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libid3tag))
