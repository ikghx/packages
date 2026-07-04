# SPDX-License-Identifier: MIT
#
# Copyright (C) 2021-2026 Wind4 & OpenWrt contributors

include $(TOPDIR)/rules.mk

PKG_NAME:=vlmcsd
PKG_VERSION:=1113
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Wind4/vlmcsd.git
PKG_SOURCE_VERSION:=70e03572b254688b8c3557f898e7ebd765d29ae1
PKG_MIRROR_HASH:=cdd543eed69ddfed7378240387cbcb88087be8397898de48ae9b750de2a58594

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=fuyumi <280604399@qq.com>

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vlmcsd
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A KMS Emulator in C
  URL:=https://github.com/Wind4/vlmcsd
  DEPENDS:=+libpthread
  USERID:=vlmcsd:vlmcsd
endef

define Package/vlmcsd/description
  KMS Emulator in C (currently runs on Linux including Android, FreeBSD,
  Solaris, Minix, Mac OS, iOS, Windows with or without Cygwin)
endef

define Package/vlmcsd/conffiles
/etc/config/vlmcsd
/etc/vlmcsd/vlmcsd.ini
endef

MAKE_FLAGS += \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	VLMCSD_VERSION="$(PKG_VERSION)"

define Package/vlmcsd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcsd $(1)/usr/bin/vlmcsd

	$(INSTALL_DIR) $(1)/etc/vlmcsd
	$(INSTALL_DATA) ./files/vlmcsd.ini $(1)/etc/vlmcsd/vlmcsd.ini
	$(INSTALL_DATA) ./files/vlmcsd.kmd $(1)/etc/vlmcsd/vlmcsd.kmd

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/vlmcsd.conf $(1)/etc/config/vlmcsd

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/vlmcsd.init $(1)/etc/init.d/vlmcsd
endef

$(eval $(call BuildPackage,vlmcsd))
