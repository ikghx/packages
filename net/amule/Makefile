#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=amule
PKG_VERSION:=3.0.0
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/amule-project/amule.git
PKG_SOURCE_VERSION:=be3f6064e5d9fde4a2c9860b2083d8cca72ea238
PKG_MIRROR_HASH:=80bb1a48cec0b2594b45eecfcc1d1a9d65917e26e270393e4d5fac1053edf3fa

PKG_BUILD_DEPENDS:=libcryptopp
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/amule
  SUBMENU:=P2P
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A multi-platform eMule-like ed2k client
  URL:=https://github.com/amule-project/amule/
  DEPENDS:=+libatomic +libpng +libpthread +libncurses +libreadline +libwxbase +libbfd \
	+libcryptopp +libcurl +boost-system +antileech +zlib +glib2-core
  USERID:=amule=4662:amule=4662
endef

TARGET_LDFLAGS += -latomic -Wl,--as-needed

CMAKE_OPTIONS += \
	-DBUILD_MONOLITHIC=NO \
	-DBUILD_DAEMON=YES \
	-DBUILD_AMULECMD=YES \
	-DBUILD_WEBSERVER=YES \
	-DBUILD_ED2K=NO \
	-DENABLE_UPNP=NO \
	-DENABLE_DLP=YES \
	-DENABLE_NLS=NO \
	-DBUILD_TESTING=NO \
	-DENABLE_MMAP=YES \
	-DwxWidgets_CONFIG_EXECUTABLE="$(STAGING_DIR)/usr/bin/wx-config" \
	-DBOOST_ROOT="$(STAGING_DIR)/usr" \
	-DSVNDATE="3.0.0-OpenWrt" \
	-DPS_RUN_RESULT=0 \
	-DPS_RUN_RESULT__TRYRUN_OUTPUT="0" \
	-DCRYPTOPP_VERSION="8.9.0"

define Package/amule/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/amule{cmd,d,web} $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/share
	$(CP) $(PKG_INSTALL_DIR)/usr/share/amule $(1)/usr/share/
endef

$(eval $(call BuildPackage,amule))
