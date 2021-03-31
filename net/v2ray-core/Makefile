#
# Copyright (C) 2019-2020 Xingwang Liao
# Copyright (C) 2019-2021 Mattraks
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray-core
PKG_VERSION:=4.36.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/v2fly/v2ray-core/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=e7f7ceefd4cd9d2e57d18cecf55228a5a126c6ed5ee53767660601c35e70535c

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Xingwang Liao <kuoruan@gmail.com>

PKG_CONFIG_DEPENDS:= \
	CONFIG_V2RAY_EXCLUDE_V2CTL \
	CONFIG_V2RAY_COMPRESS_GOPROXY \
	CONFIG_V2RAY_COMPRESS_UPX

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/v2fly/v2ray-core/v4
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:= \
	$(GO_PKG).version=$(PKG_VERSION) \
	$(GO_PKG).build=R$(PKG_RELEASE) \
	$(GO_PKG).codename=OpenWrt

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/v2ray/template
  TITLE:=A platform for building proxies to bypass network restrictions.
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Project V
  URL:=https://www.v2fly.org
endef

define Package/v2ray-core
  $(call Package/v2ray/template)
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
  PROVIDES:=v2ray
endef

define Package/v2ray-geodata
  $(call Package/v2ray/template)
  TITLE+= (geodata files)
  DEPENDS:=v2ray-core
endef

define Package/v2ray/description
  Project V is a set of network tools that help you to build your own computer network.
  It secures your network connections and thus protects your privacy.
endef

define Package/v2ray-core/description
  $(call Package/v2ray/description)
endef

define Package/v2ray-geodata/description
  $(call Package/v2ray/description)

  This includes GEO datas used for v2ray-core.
endef

define Package/$(PKG_NAME)/config
config V2RAY_COMPRESS_GOPROXY
	bool "Compiling with GOPROXY proxy"
	default n

config V2RAY_EXCLUDE_V2CTL
	bool "Exclude V2Ctl"
	default y

config V2RAY_COMPRESS_UPX
	bool "Compress executable files with UPX"
	default y
endef

ifeq ($(CONFIG_V2RAY_COMPRESS_GOPROXY),y)
export GO111MODULE=on
export GOPROXY=https://goproxy.io
#export GOPROXY=https://mirrors.aliyun.com/goproxy/
endif

GEOIP_VER:=202103302203
GEOIP_FILE:=geoip.dat.$(GEOIP_VER)

define Download/geoip
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOIP_VER)/
  URL_FILE:=geoip.dat
  FILE:=$(GEOIP_FILE)
  HASH:=969043ce2f307f79a617a2d82daa1dcfdba4ad72fefb7e4b70233ad45d221946
endef

GEOSITE_VER:=202103302203
GEOSITE_FILE:=geosite.dat.$(GEOSITE_VER)

define Download/geosite
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOSITE_VER)/
  URL_FILE:=geosite.dat
  FILE:=$(GEOSITE_FILE)
  HASH:=9fba42672073b3d21e9e2e514b26f4a12d08319718ab878a8eda6f6b375a1485
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_v2ray-geodata),)
	$(call Download,geoip)
	$(call Download,geosite)
endif
endef

define Build/Compile
	$(eval GO_PKG_BUILD_PKG:=$(GO_PKG)/main)
	$(call GoPackage/Build/Compile)
	mv -f $(GO_PKG_BUILD_BIN_DIR)/main $(GO_PKG_BUILD_BIN_DIR)/v2ray

ifeq ($(CONFIG_V2RAY_COMPRESS_UPX),y)
	upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/v2ray || true
endif

ifneq ($(CONFIG_V2RAY_EXCLUDE_V2CTL),y)
	$(eval GO_PKG_BUILD_PKG:=$(GO_PKG)/infra/control/main)
	$(call GoPackage/Build/Compile)
	mv -f $(GO_PKG_BUILD_BIN_DIR)/main $(GO_PKG_BUILD_BIN_DIR)/v2ctl

ifeq ($(CONFIG_V2RAY_COMPRESS_UPX),y)
	upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/v2ctl || true
endif
endif
endef

define Package/$(PKG_NAME)/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/v2ray $(1)/usr/bin

ifneq ($(CONFIG_V2RAY_EXCLUDE_V2CTL),y)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/v2ctl $(1)/usr/bin
endif
endef

define Package/v2ray-geodata/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DATA) $(DL_DIR)/$(GEOIP_FILE) $(1)/usr/bin/geoip.dat
	$(INSTALL_DATA) $(DL_DIR)/$(GEOSITE_FILE) $(1)/usr/bin/geosite.dat
	$(INSTALL_DATA) ./files/* $(1)/usr/bin
endef

$(eval $(call BuildPackage,v2ray-core))
$(eval $(call BuildPackage,v2ray-geodata))
