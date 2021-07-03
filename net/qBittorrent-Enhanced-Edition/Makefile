#
# Copyright (C) 2017-2021
#
# This is free software, licensed under the GNU General Public License v2.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=qBittorrent-Enhanced-Edition
PKG_VERSION:=4.3.6.10
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-release-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/c0re100/qBittorrent-Enhanced-Edition/tar.gz/release-$(PKG_VERSION)?
PKG_HASH:=2e490ff1ccc85b339761d3f5fbc149bb085c3664ad6be93152af4946bf310303

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-release-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DEPENDS:=qttools boost

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=BitTorrent
	DEPENDS:=+libgcc +libstdcpp \
		+libtorrent-rasterbar \
		+libopenssl \
		+libqt5core \
		+libqt5network \
		+libqt5sql \
		+libqt5xml \
		+zlib
	TITLE:=bittorrent client programmed in C++ / Qt
	URL:=https://github.com/c0re100/qBittorrent-Enhanced-Edition
endef

define Package/$(PKG_NAME)/description
	qBittorrent is a bittorrent client programmed in C++ / Qt that uses 
	libtorrent (sometimes called libtorrent-rasterbar) by Arvid Norberg.
	It aims to be a good alternative to all other bittorrent clients out 
	there. qBittorrent is fast, stable and provides unicode support as 
	well as many features.
endef

CONFIGURE_ARGS += \
	--disable-gui \
	--enable-stacktrace=no \
	--with-boost=$(STAGING_DIR)/usr

MAKE_VARS += \
	INSTALL_ROOT="$(PKG_INSTALL_DIR)"

TARGET_CFLAGS += -std=c++17 -ffunction-sections -fdata-sections -flto
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed

define Package/qbittorrent/conffiles
/etc/config/qbittorrent
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/etc/config
	$(INSTALL_BIN) ./files/qbittorrent-enhanced.init $(1)/etc/init.d/qbittorrent-enhanced
	$(INSTALL_CONF) ./files/qbittorrent-enhanced.conf $(1)/etc/config/qbittorrent-enhanced

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/qbittorrent-nox $(1)/usr/bin/qbittorrent-nox-enhanced
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
