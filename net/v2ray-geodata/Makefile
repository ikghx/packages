# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray-geodata
PKG_RELEASE:=1

PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Tianling Shen <cnsztl@immortalwrt.org>

include $(INCLUDE_DIR)/package.mk

GEOIP_VER:=202301262210
GEOIP_FILE:=geoip.dat.$(GEOIP_VER)
define Download/geoip
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOIP_VER)/
  URL_FILE:=geoip.dat
  FILE:=$(GEOIP_FILE)
  HASH:=2edb9a068488af4546f6be95143e01a1d83ef4da98cec452892f52bf49d49328
endef

GEOSITE_VER:=202301262210
GEOSITE_FILE:=geosite.dat.$(GEOSITE_VER)
define Download/geosite
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOSITE_VER)/
  URL_FILE:=geosite.dat
  FILE:=$(GEOSITE_FILE)
  HASH:=1b5da54bc05bd53159fa63ad05614c94bf63d15a8ded20372e951f073b85377f
endef

define Package/v2ray-geodata/template
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Project V
  URL:=https://www.v2fly.org
  PKGARCH:=all
endef

define Package/v2ray-geoip
  $(call Package/v2ray-geodata/template)
  TITLE:=GeoIP List for V2Ray
  VERSION:=$(GEOIP_VER)-$(PKG_RELEASE)
  LICENSE:=CC-BY-SA-4.0
endef

define Package/v2ray-geosite
  $(call Package/v2ray-geodata/template)
  TITLE:=Geosite List for V2Ray
  VERSION:=$(GEOSITE_VER)-$(PKG_RELEASE)
  LICENSE:=MIT
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_v2ray-geoip),)
	$(call Download,geoip)
endif
ifneq ($(CONFIG_PACKAGE_v2ray-geosite),)
	$(call Download,geosite)
endif
endef

define Build/Compile
endef

define Package/v2ray-geoip/install
	$(INSTALL_DIR) $(1)/usr/share/v2ray $(1)/usr/bin
	$(INSTALL_DATA) $(DL_DIR)/$(GEOIP_FILE) $(1)/usr/share/v2ray/geoip.dat
	$(LN) /usr/share/v2ray/geoip.dat $(1)/usr/bin/geoip.dat
endef

define Package/v2ray-geosite/install
	$(INSTALL_DIR) $(1)/usr/share/v2ray $(1)/usr/bin
	$(INSTALL_DATA) $(DL_DIR)/$(GEOSITE_FILE) $(1)/usr/share/v2ray/geosite.dat
	$(LN) /usr/share/v2ray/geosite.dat $(1)/usr/bin/geosite.dat
endef

$(eval $(call BuildPackage,v2ray-geoip))
$(eval $(call BuildPackage,v2ray-geosite))
