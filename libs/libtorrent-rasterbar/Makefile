#
# Copyright (C) 2007-2021
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libtorrent-rasterbar
PKG_VERSION:=2.0.5
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2022-02-16
PKG_SOURCE_URL:=https://github.com/arvidn/libtorrent.git
PKG_SOURCE_VERSION:=1f3900527273401a76af7ed04bcf147cbae478f0
PKG_MIRROR_HASH:=b7221c6173c3a6ca94c1b7b27094fdf0becb979274a48d1d674e1322ea56ad93

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:libtorrent:libtorrent

PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libtorrent-rasterbar
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=C++ bittorrent library by Rasterbar Software
	URL:=https://www.libtorrent.org
	DEPENDS:=+boost +boost-system +libatomic +libc +libgcc +libopenssl +libstdcpp +USE_GLIBC:libpthread
	ABI_VERSION:=2.0
endef

define Package/libtorrent-rasterbar/description
  Libtorrent is a feature complete C++ bittorrent implementation focusing on
  efficiency and scalability. It runs on embedded devices as well as desktops.
  It boasts a well documented library interface that is easy to use.
endef

TARGET_CFLAGS += $(FPIC) -ffunction-sections -fdata-sections -flto
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed -flto

CMAKE_OPTIONS += \
	-DBUILD_SHARED_LIBS=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-Ddeprecated-functions=OFF \
	-Dlogging=OFF \
	-DCMAKE_CXX_STANDARD=17 \
	-Dpython-bindings=$(if $(CONFIG_PACKAGE_python3-libtorrent),ON,OFF) \
	-Dpython-egg-info=$(if $(CONFIG_PACKAGE_python3-libtorrent),ON,OFF)

define Build/InstallDev
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)
endef

define Package/libtorrent-rasterbar/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtorrent-rasterbar.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libtorrent-rasterbar))
