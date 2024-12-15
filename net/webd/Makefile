#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=webd
PKG_VERSION:=20240223
PKG_RELEASE:=1

ifeq ($(ARCH),x86_64)
	PKG_ARCH:=amd64
endif
ifeq ($(BOARD),bcm53xx)
	PKG_ARCH:=bcm53xx
endif
ifeq ($(BOARD),ipq40xx)
	PKG_ARCH:=ipq40xx
endif
ifeq ($(BOARD),ipq806x)
	PKG_ARCH:=ipq806x
endif
ifeq ($(ARCH),mips)
	PKG_ARCH:=mips
endif
ifeq ($(ARCH),mipsel)
	PKG_ARCH:=mipsel
endif
ifeq ($(BOARD),mvebu)
	PKG_ARCH:=mvebu
endif
ifeq ($(ARCH),aarch64)
	PKG_ARCH:=aarch64
endif

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=webd
	DEPENDS:=@(x86_64||arm||aarch64||mipsel||mips)
	URL:=http://webd.cf/
endef

define Package/$(PKG_NAME)/description
	This package for webd binary.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/$(PKG_ARCH)/webd $(1)/usr/bin/webd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/webd.init $(1)/etc/init.d/webd
endef

$(eval $(call BuildPackage,webd))
