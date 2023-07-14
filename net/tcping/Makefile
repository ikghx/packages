#
# Copyright (C) 2014 OpenWrt-dist
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk


PKG_NAME:=tcping
PKG_VERSION:=0.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Lienol/tcping
PKG_SOURCE_DATE:=2020-07-04
PKG_SOURCE_VERSION:=db9101834732dac9aaa59dbb7fb9c74612dbf723
PKG_MIRROR_HASH:=a3b44d671efd00493a07012e89c63190eaed561574ce72166f12dcd44cc85cdc

include $(INCLUDE_DIR)/package.mk

define Package/tcping
  SECTION:=net
  CATEGORY:=Network
  TITLE:=tcping measures the latency of a tcp-connection
  URL:=https://github.com/Lienol/tcping
endef

define Package/tcping/description
endef

define Package/tcping/conffiles
endef

define Package/tcping/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tcping $(1)/usr/sbin
endef

$(eval $(call BuildPackage,tcping))