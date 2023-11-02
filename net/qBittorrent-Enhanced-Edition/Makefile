# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2017-2023 bishuiwuhen

include $(TOPDIR)/rules.mk

PKG_NAME:=qBittorrent-Enhanced-Edition
PKG_VERSION:=4.6.0.10
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-release-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/c0re100/qBittorrent-Enhanced-Edition/tar.gz/release-$(PKG_VERSION)?
PKG_HASH:=22ef335a4fa2f8d90c97cbf48efbf6d77fb86853c2faee7271400a5466427112

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-release-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DEPENDS:=\
	boost  qttools/host libtorrent-rasterbar \
	openssl qtbase zlib

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_BUILD_FLAGS:=no-mips16

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=BitTorrent
	DEPENDS:= \
		+@PACKAGE_boost +@PACKAGE_boost-system \
		+libgcc +libstdcpp \
		+libtorrent-rasterbar \
		+libopenssl \
		+libqt6core \
		+libqt6network \
		+libqt6network-tlsbackend-openssl \
		+libqt6sql \
		+libqt6sql-sqlite \
		+libqt6xml \
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

CMAKE_SHARED_LDFLAGS:=$(filter-out -Wl$(comma)-Bsymbolic-functions,$(CMAKE_SHARED_LDFLAGS))

CMAKE_OPTIONS += \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_STANDARD=17 \
	-DQT6=ON \
	-DSTACKTRACE=OFF \
	-DWEBUI=ON \
	-DGUI=OFF \
	-DVERBOSE_CONFIGURE=ON \
	-DQT_ADDITIONAL_PACKAGES_PREFIX_PATH=$(STAGING_DIR_HOSTPKG)

# The pcre2 is compiled with support for mips16
ifdef CONFIG_USE_MIPS16
  TARGET_CFLAGS += -minterlink-mips16
endif

# Support the glibc
ifdef CONFIG_USE_GLIBC
  TARGET_LDFLAGS += -ldl -lrt -lpthread
endif

TARGET_CFLAGS += $(FPIC) -ffunction-sections -fdata-sections -flto=auto -fno-fat-lto-objects
TARGET_LDFLAGS += $(FPIC) -specs=$(INCLUDE_DIR)/hardened-ld-pie.specs -Wl,--gc-sections,--as-needed -flto=auto -fuse-linker-plugin

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
