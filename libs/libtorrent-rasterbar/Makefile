include $(TOPDIR)/rules.mk

PKG_NAME:=libtorrent-rasterbar
PKG_VERSION:=2.0.11
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-10-02
PKG_SOURCE_URL:=https://github.com/arvidn/libtorrent.git
PKG_SOURCE_VERSION:=a3cdc510794515f26b7736218041926d3544206a
PKG_MIRROR_HASH:=f4873a166515d7f7d279429f43520185083658c83bf0d446c4814aff84cecdad

PKG_MAINTAINER:=David Yang <mmyangfl@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libtorrent-rasterbar/Default
	TITLE:=Rasterbar BitTorrent library
	URL:=https://libtorrent.org/
endef

define Package/libtorrent-rasterbar
	$(call Package/libtorrent-rasterbar/Default)
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+boost +boost-system +libatomic +libgcc +libopenssl +libstdcpp
endef

define Package/libtorrent-rasterbar/description
	Rasterbar libtorrent is a C++ library that aims to be a good alternative to
	all the other bittorrent implementations around.
endef

TARGET_CFLAGS += $(FPIC) -ffunction-sections -fdata-sections -flto=auto -fno-fat-lto-objects
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed -flto=auto -fuse-linker-plugin

CMAKE_OPTIONS += \
	-DBUILD_SHARED_LIBS=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-Ddeprecated-functions=OFF \
	-Dlogging=OFF \
	-DCMAKE_CXX_STANDARD=17 \
	-Dpython-bindings=OFF

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/libtorrent $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtorrent-rasterbar.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libtorrent-rasterbar.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libtorrent-rasterbar/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtorrent-rasterbar.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libtorrent-rasterbar))
