#
# Copyright (C) 2021 - ntop.org and contributors
#

include $(TOPDIR)/rules.mk

PKG_NAME:=n2n
PKG_SOURCE_URL:=https://github.com/ntop/n2n.git
PKG_SOURCE_VERSION:=0177e140262911781d5d92371e40de94c504c8ac
PKG_VERSION:=3.0.0_git$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_MIRROR_HASH:=71f5d46a4471046a1cbfddbca686e1f4db40bb022f0cc711630af5332cf012bf

PKG_MAINTAINER:=Emanuele Faranda <faranda@ntop.org>
PKG_LICENSE:=GPL3

# autogen fix
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/n2n/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=N2N Peer-to-peer VPN
  URL:=http://www.ntop.org/n2n
  SUBMENU:=VPN
  DEPENDS+=+libcap
endef

define Package/n2n-edge
  $(call Package/n2n/Default)
  TITLE+= client (edge node)
  DEPENDS+=+kmod-tun +resolveip +libopenssl +libzstd
endef

define Package/n2n-supernode
  $(call Package/n2n/Default)
  TITLE+= server (supernode)
  DEPENDS+=+libopenssl +libzstd
endef

define Package/n2n-edge/description
The client node for the N2N infrastructure
endef

define Package/n2n-supernode/description
The supernode for the N2N infrastructure
endef

define Build/Configure
	( cd $(PKG_BUILD_DIR); \
	./autogen.sh; \
	./configure )
endef

CONFIGURE_ARGS += \
	--with-zstd \
	--with-openssl

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
endef

$(eval $(call BuildPackage,n2n-edge))
$(eval $(call BuildPackage,n2n-supernode))
