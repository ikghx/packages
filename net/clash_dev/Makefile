#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=clash_dev
PKG_VERSION:=v1.11.0-7-g5497ada
PKG_RELEASE:=1

ifeq ($(ARCH),i386)
	PKG_ARCH_clash:=386
endif
ifeq ($(ARCH),x86_64)
	PKG_ARCH_clash:=amd64
endif
ifeq ($(BOARD),kirkwood)
	PKG_ARCH_clash:=armv5
endif
ifeq ($(BOARD),bcm53xx)
	PKG_ARCH_clash:=armv6
endif
ifeq ($(ARCH),arm)
	PKG_ARCH_clash:=armv7
endif
ifeq ($(ARCH),arm64)
	PKG_ARCH_clash:=armv8
endif
ifeq ($(ARCH),aarch64)
	PKG_ARCH_clash:=armv8
endif
ifeq ($(ARCH),mips)
	PKG_ARCH_clash:=mips
endif
ifeq ($(ARCH),mipsel)
	PKG_ARCH_clash:=mipsel
endif

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Clash Dev
	DEPENDS:=@(i386||x86_64||arm||mipsel||mips||arm64||aarch64)
	URL:=https://github.com/vernesong/OpenClash/releases/tag/Clash
endef

define Package/$(PKG_NAME)/description
	This package for Clash Dev.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/openclash/core
	$(INSTALL_BIN) ./files/$(PKG_ARCH_clash)/clash $(1)/etc/openclash/core/clash
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
