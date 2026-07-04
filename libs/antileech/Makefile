# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021-2022 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=antileech
PKG_VERSION:=4405
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2021-12-05
PKG_SOURCE_URL:=https://github.com/persmule/amule-dlp.antiLeech.git
PKG_SOURCE_VERSION:=1b14ed828ed227933333de31ffb8e24e6c10451c
PKG_MIRROR_HASH:=71ecd127928528b5e263db4af618fb73db9b9f65e1725ee9b71b9b13a7237b96

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/antileech
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=AntiLeech for aMule
  URL:=https://github.com/persmule/amule-dlp.antiLeech
  DEPENDS:=+libwxbase
endef

define Package/antileech/description
  Dynamic Leech Protection(DLP) is a part of eMule Xtreme Mod at first.
  This project aim to make DLP available for aMule. This repo contains
  the plugin library "libantiLeech".
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(SED) "s:^AC_CHECK_PROG.WXCONFIG,.*::g" $(PKG_BUILD_DIR)/configure.ac
	$(SED) "s:wx-config --cppflags:$(STAGING_DIR)/usr/bin/wx-config --cppflags:g" $(PKG_BUILD_DIR)/configure.ac
endef

TARGET_CXXFLAGS += -Wno-error=narrowing

MAKE_FLAGS += HOSTCC="$(HOSTCC)"

define Package/antileech/install
	$(INSTALL_DIR) $(1)/usr/share/amule
	$(CP) $(PKG_INSTALL_DIR)/usr/share/amule/libantiLeech.so $(1)/usr/share/amule/
endef

$(eval $(call BuildPackage,antileech))
