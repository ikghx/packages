#
# Copyright (C) 2016 Toke Høiland-Jørgensen
#
# This is free software, licensed under the GNU General Public License v3 or
# later.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=acme-acmesh
PKG_VERSION:=2026.03.13
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/acmesh-official/acme.sh.git
PKG_SOURCE_VERSION:=5d158b164028b240e0710a8d7a0ce4835a0ba1be
PKG_MIRROR_HASH:=38b29d4773d42d617d9d68f3564eaa35d23db5b6e2dc947a302db2ba5d82b203

PKG_MAINTAINER:=Toke Høiland-Jørgensen <toke@toke.dk>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.md

include $(INCLUDE_DIR)/package.mk

define Package/acme-acmesh
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+acme-common +wget-ssl +ca-bundle +openssl-util +socat
  TITLE:=ACME client acme.sh wrapper script
  URL:=https://acme.sh
  PKGARCH:=all
  PROVIDES:=acme-client
endef

define Package/acme-acmesh/description
A client for issuing ACME (e.g, Letsencrypt) certificates.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/acme-acmesh/install
	$(INSTALL_DIR) $(1)/usr/lib/acme/client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/acme.sh $(1)/usr/lib/acme/client
	$(INSTALL_BIN) ./files/hook.sh $(1)/usr/lib/acme/hook
endef

define Package/acme-acmesh-dnsapi
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+acme-acmesh
  TITLE:=DNS API integration for ACME (Letsencrypt) client
  PKGARCH:=all
endef

define Package/acme-acmesh-dnsapi/description
 This package provides DNS API integration for ACME (Letsencrypt) client.
endef

define Package/acme-acmesh-dnsapi/install
	$(INSTALL_DIR) $(1)/usr/lib/acme/client/dnsapi
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/dnsapi/*.sh $(1)/usr/lib/acme/client/dnsapi
endef

$(eval $(call BuildPackage,acme-acmesh))
$(eval $(call BuildPackage,acme-acmesh-dnsapi))
