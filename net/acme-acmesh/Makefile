#
# Copyright (C) 2016 Toke Høiland-Jørgensen
#
# This is free software, licensed under the GNU General Public License v3 or
# later.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=acme-acmesh
PKG_VERSION:=2026.09.20
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/acmesh-official/acme.sh.git
PKG_SOURCE_VERSION:=807da6498377ee5e0cf43a78091f46f12dc59a89
PKG_MIRROR_HASH:=89ac81c236d041d8abbbb21b08ca8a4518753c95355561203542af530ab7a221

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
