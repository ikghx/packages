# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 - ntop.org and contributors
#

include $(TOPDIR)/rules.mk

PKG_NAME:=n2n
PKG_VERSION:=3.0.0
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ntop/n2n.git
PKG_SOURCE_VERSION:=3d5a88f969450b10e575b942f02e419d5acd6173
PKG_MIRROR_HASH:=3670478c67ce4db30606fe4ec9a49f2ec38c6724990c47016f4a4d7a80684412

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Emanuele Faranda <faranda@ntop.org>

PKG_BUILD_DEPENDS:=libpcap
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/n2n/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=N2N Peer-to-peer VPN
  URL:=http://www.ntop.org/n2n
  DEPENDS:=+libcap
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

define Package/n2n-utils
  $(call Package/n2n/Default)
  TITLE+= extend utilities
  DEPENDS+=+libpcap +libopenssl +libzstd
endef

define Package/n2n-edge/description
The client node for the N2N infrastructure
endef

define Package/n2n-supernode/description
The supernode for the N2N infrastructure
endef

define Package/n2n-utils/description
  This package contains extend utilities for the N2N infrastructure.
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
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/edge $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/edge $(1)/etc/init.d/edge
	$(INSTALL_DIR) $(1)/etc/n2n
	$(INSTALL_CONF) ./files/edge.conf.sample $(1)/etc/n2n/edge.conf
endef

define Package/n2n-supernode/conffiles
/etc/n2n/supernode.conf
endef

define Package/n2n-supernode/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/supernode $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/supernode $(1)/etc/init.d/supernode
	$(INSTALL_DIR) $(1)/etc/n2n
	$(INSTALL_CONF) ./files/supernode.conf.sample $(1)/etc/n2n/supernode.conf
	$(INSTALL_CONF) ./files/communities.list $(1)/etc/n2n/communities.list
endef

define Package/n2n-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/n2n-benchmark $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/n2n-decode $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/n2n-keygen $(1)/usr/bin/
endef

$(eval $(call BuildPackage,n2n-edge))
$(eval $(call BuildPackage,n2n-supernode))
$(eval $(call BuildPackage,n2n-utils))
