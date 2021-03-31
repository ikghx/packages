#
# Copyright (C) 2021 CTCGFW Project-OpenWrt
# <https://project-openwrt.eu.org>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ipt2socks
PKG_VERSION:=1.1.3
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/zfl9/ipt2socks.git
PKG_MIRROR_HASH:=914465049c065c9fd21a6eabb96418acf134f2b6f0a1b861d5987ae0d10da83a
PKG_SOURCE_VERSION:=384dab4bae5ed9402e07ec1950e502c05812bc26
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_LICENSE:=AGPL-3.0
PKG_LICENSE_FILE:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/ipt2socks
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Utility for converting iptables (REDIRECT/TPROXY) to SOCKS5
	URL:=https://github.com/zfl9/ipt2socks
	DEPENDS:=+libpthread
endef

TARGET_CFLAGS += $(FPIC) -flto
TARGET_LDFLAGS += -flto

define Package/ipt2socks/description
Utility for converting iptables (REDIRECT/TPROXY) to SOCKS5.
endef

define Package/ipt2socks/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/ipt2socks $(1)/usr/bin
endef

$(eval $(call BuildPackage,ipt2socks))
