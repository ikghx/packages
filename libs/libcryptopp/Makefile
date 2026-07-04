# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021-2023 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=libcryptopp
PKG_VERSION:=8.9.0
PKG_RELEASE:=3

PKG_SOURCE:=cryptopp$(subst .,,$(PKG_VERSION)).zip
PKG_SOURCE_URL:=https://github.com/weidai11/cryptopp/releases/download/CRYPTOPP_$(subst .,_,$(PKG_VERSION))/ \
		https://www.cryptopp.com/
PKG_HASH:=4cc0ccc324625b80b695fcd3dee63a66f1a460d3e51b71640cdbfc4cd1a3779c

PKG_LICENSE:=BSL-1.0
PKG_LICENSE_FILES:=License.txt
PKG_CPE_ID:=cpe:/a:cryptopp:crypto++

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libcryptopp
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Free C++ class library of cryptographic schemes
  URL:=https://packages.debian.org/sid/libcrypto++-dev
  DEPENDS:=+libpthread +libstdcpp
endef

define Package/libcryptopp/description
  Crypto++ is library for creating C++ programs which use cryptographic
  algorithms. The library uses a Pipes & Filters architecture with heavy
  use of templates and abstract base classes.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	unzip -q -d $(PKG_BUILD_DIR) $(DL_DIR)/$(PKG_SOURCE)
	$(Build/Patch)
endef

MAKE_FLAGS += \
	PREFIX=/usr \
	CXX="$(TARGET_CXX)" \
	CXXFLAGS="$(TARGET_CXXFLAGS) $(TARGET_CPPFLAGS) -fPIC" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	dynamic libcryptopp.pc

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/cryptopp
	$(CP) $(PKG_INSTALL_DIR)/usr/include/cryptopp/* $(1)/usr/include/cryptopp/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libcryptopp.pc $(1)/usr/lib/pkgconfig/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcryptopp.so* $(1)/usr/lib/
endef

define Package/libcryptopp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcryptopp.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libcryptopp))
