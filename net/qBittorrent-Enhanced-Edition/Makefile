#
# Copyright (C) 2017-2021
#
# This is free software, licensed under the GNU General Public License v2.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=qBittorrent-Enhanced-Edition
PKG_VERSION:=4.4.3.11
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-release-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/c0re100/qBittorrent-Enhanced-Edition/tar.gz/release-$(PKG_VERSION)?
PKG_HASH:=1c64434789fd6b09f841cf6a3d6544c021e53327181dafee649f08e56fcc03ae

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-release-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DEPENDS:=qttools/host boost

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=BitTorrent
	DEPENDS:= \
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

CMAKE_OPTIONS += \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_STANDARD=17 \
	-DQT6=ON \
	-DSTACKTRACE=OFF \
	-DWEBUI=ON \
	-DGUI=OFF \
	-DVERBOSE_CONFIGURE=ON \
	-DQT_ADDITIONAL_PACKAGES_PREFIX_PATH=$(STAGING_DIR_HOSTPKG)

# The pentium-mmx with lto will build failed on qt6
ifeq ($(findstring pentium-mmx,$(CONFIG_CPU_TYPE)),)
  CMAKE_OPTIONS += -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON
endif

# The pcre2 is compiled with support for mips16
ifdef CONFIG_USE_MIPS16
  TARGET_CFLAGS += -minterlink-mips16
endif

# Support the glibc
ifdef CONFIG_USE_GLIBC
  TARGET_LDFLAGS += -ldl -lrt -lpthread
endif

TARGET_CFLAGS += -ffunction-sections -fdata-sections
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
