include $(TOPDIR)/rules.mk

PKG_NAME:=microsocks
PKG_VERSION=1.0.2
PKG_RELEASE:=1

PKG_MAINTAINER:=lean
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/rofl0r/microsocks.git
PKG_MIRROR_HASH:=0b588a6e4a699de956327381874d0f5e7727e7de5d723c8c4411b5f1944f3add
PKG_SOURCE_VERSION:=ef6f8e3329736418cade06da9f16c308f7bcd433

PKG_SOURCE:=$(PKG_NAME).$(PKG_VERSION).tar.gz
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/microsocks
	SECTION:=net
	CATEGORY:=Network
	TITLE:=microsocks for OpenWRT
endef

define Package/microsocks/description
	microsocks is a Tiny Proxy in C.
endef

define Package/microsocks/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/microsocks $(1)/usr/bin/microsocks
endef

$(eval $(call BuildPackage,microsocks))
