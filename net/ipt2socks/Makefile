# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=ipt2socks
PKG_VERSION:=1.1.3
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/zfl9/ipt2socks.git
PKG_SOURCE_DATE:=2020-07-20
PKG_SOURCE_VERSION:=384dab4bae5ed9402e07ec1950e502c05812bc26
PKG_MIRROR_HASH:=fc73ec16fd7e057d6639686e2252e42f1c1676753675b1406bbb1dfee8ee508b

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_LICENSE:=AGPL-3.0
PKG_LICENSE_FILE:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/ipt2socks
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Convert iptables to socks5
  URL:=https://github.com/zfl9/ipt2socks
  DEPENDS:=+libpthread +libuv
endef

define Package/ipt2socks/description
  Utility for converting iptables (redirect/tproxy) to socks5.
endef

TARGET_CFLAGS += $(FPIC) -flto
TARGET_LDFLAGS += -flto

define Package/ipt2socks/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/ipt2socks $(1)/usr/bin
endef

$(eval $(call BuildPackage,ipt2socks))
