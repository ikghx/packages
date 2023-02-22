# SPDX-License-Identifer: GPL-3.0-only
#
# Copyright (C) 2021 - ntop.org and contributors
#

include $(TOPDIR)/rules.mk

PKG_NAME:=n2n
PKG_SOURCE_URL:=https://github.com/ntop/n2n.git
PKG_SOURCE_VERSION:=6dac89f1a71358e52649e0dec9de53cadd3411d8
PKG_VERSION:=3.0.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_MIRROR_HASH:=1818cf492307f9667a58dee2fabfa46a3d7a8f9e1aaeabfe58d2db9d0f946776

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Emanuele Faranda <faranda@ntop.org>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/n2n/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=N2N Peer-to-peer VPN
  URL:=http://www.ntop.org/n2n
  DEPENDS+=+libcap
endef

define Package/n2n-edge
  $(call Package/n2n/Default)
  TITLE+= client (edge node)
  DEPENDS+=+kmod-tun +resolveip +libopenssl +libpthread +libzstd
endef

define Package/n2n-supernode
  $(call Package/n2n/Default)
  TITLE+= server (supernode)
  DEPENDS+=+libopenssl +libpthread +libzstd
endef

define Package/n2n-edge/description
The client node for the N2N infrastructure
endef

define Package/n2n-supernode/description
The supernode for the N2N infrastructure
endef

define Build/Configure
	( cd $(PKG_BUILD_DIR); ./autogen.sh )
	$(call Build/Configure/Default)
endef

CMAKE_OPTIONS+= \
	-DCMAKE_BUILD_TYPE=Release \
	-DN2N_OPTION_USE_PTHREAD=ON \
	-DN2N_OPTION_USE_OPENSSL=ON \
	-DN2N_OPTION_USE_PCAPLIB=ON \
	-DN2N_OPTION_USE_ZSTD=ON

define Package/n2n-edge/conffiles
/etc/n2n/edge.conf
endef

define Package/n2n-edge/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/edge $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/edge $(1)/etc/init.d/edge
	$(INSTALL_DIR) $(1)/etc/n2n
	$(INSTALL_CONF) ./files/edge.conf.sample $(1)/etc/n2n/edge.conf
endef

define Package/n2n-supernode/conffiles
/etc/n2n/supernode.conf
endef

define Package/n2n-supernode/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/supernode $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/supernode $(1)/etc/init.d/supernode
	$(INSTALL_DIR) $(1)/etc/n2n
	$(INSTALL_CONF) ./files/supernode.conf.sample $(1)/etc/n2n/supernode.conf
	$(INSTALL_CONF) ./files/communities.list $(1)/etc/n2n/communities.list
endef

$(eval $(call BuildPackage,n2n-edge))
$(eval $(call BuildPackage,n2n-supernode))
