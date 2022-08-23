#
# Copyright (C) 2019 Lucian Cristian <lucian.cristian@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=libreswan
PKG_VERSION:=4.7
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://download.libreswan.org/
PKG_HASH:=ddd6337b3900063d870301c3d9f61f56107c765850fb00a163d360359ff3fc44

PKG_MAINTAINER:=Lucian Cristian <lucian.cristian@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING LICENSE
PKG_CPE_ID:=cpe:/a:libreswan:libreswan

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libreswan/Default
  TITLE:=Libreswan
  URL:=https://libreswan.org/
endef

define Package/libreswan/Default/description
 Libreswan is a free software implementation of the most widely supported and
 standardized VPN protocol based on ("IPsec") and the Internet Key Exchange
 ("IKE"). These standards are produced and maintained by the Internet
 Engineering Task Force ("IETF").
endef

define Package/libreswan
$(call Package/libreswan/Default)
  SUBMENU:=VPN
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:= +IPV6:kmod-ip6-vti +IPV6:kmod-ipsec6 +ip-full \
	+kmod-crypto-aead +kmod-crypto-authenc +kmod-crypto-gcm \
	+kmod-crypto-hash +kmod-crypto-rng +kmod-ip-vti +kmod-ipsec \
	+kmod-ipsec4 +kmod-xfrm-interface +libevent2 +libevent2-pthreads \
	+libldns +librt +libunbound +nss-utils +nspr +libcap-ng \
	+iptables-mod-ipsec +kmod-ipt-ipsec
  PROVIDES:=openswan
  CONFLICTS:=strongswan
  TITLE+= IPsec Server
endef

define Package/libreswan/description
$(call Package/libreswan/Default/description)
 Libreswan is a free software implementation of the most widely supported and
 standardized VPN protocol based on ("IPsec") and the Internet Key Exchange
 ("IKE"). These standards are produced and maintained by the Internet
 Engineering Task Force ("IETF").
endef

define Package/libreswan/conffiles
/etc/ipsec.d
/etc/config/libreswan
/etc/ipsec.user
endef

TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed
TARGET_CFLAGS += -flto

MAKE_FLAGS+= \
    WERROR_CFLAGS=" " \
    NSS_REQ_AVA_COPY=false \
    USE_LINUX_AUDIT=false \
    USE_LABELED_IPSEC=false \
    USE_NM=false \
    USE_NSS_KDF=true \
    USE_LIBCURL=false \
    USE_GLIBC_KERN_FLIP_HEADERS=true \
    USE_AUTHPAM=false \
    USE_LIBCAP_NG=true \
    USE_SYSTEMD_WATCHDOG=false \
    USE_SECCOMP=false\
    USE_XFRM_INTERFACE_IFLA_HEADER=false \
    PREFIX="/usr" \
    FINALRUNDIR="/var/run/pluto" \
    FINALNSSDIR="/etc/ipsec.d" \
    MODPROBEARGS="-q" \
    OSDEP=linux \
    BUILDENV=linux \
    ARCH="$(LINUX_KARCH)" \

define Build/Prepare
	$(call Build/Prepare/Default)
	$(SED) 's,include $$$$(top_srcdir)/mk/manpages.mk,,g' \
            $(PKG_BUILD_DIR)/mk/program.mk
endef

define Build/Compile
	$(call Build/Compile/Default,all)
endef

define Package/libreswan/install
	$(INSTALL_DIR) \
	 $(1)/etc/ipsec.d/policies \
	 $(1)/usr/libexec/ipsec \
	 $(1)/usr/sbin \
	 $(1)/etc/config \
	 $(1)/etc/init.d \
	 $(1)/etc/hotplug.d/libreswan \
	 $(1)/usr/libexec/rpcd

	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/ipsec  \
	    $(1)/usr/sbin/ipsec
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/ipsec.d/policies/* \
	     $(1)/etc/ipsec.d/policies/
	$(CP) $(PKG_INSTALL_DIR)/usr/libexec/ipsec/* \
	    $(1)/usr/libexec/ipsec/

	$(INSTALL_BIN) ./files/updown.openwrt $(1)/usr/libexec/ipsec/_updown.xfrm
	$(INSTALL_BIN) ./files/ipsec.init $(1)/etc/init.d/ipsec
	$(INSTALL_DATA) ./files/ipsec.conf $(1)/etc/ipsec.conf
	$(INSTALL_DATA) ./files/ipsec.secrets $(1)/etc/ipsec.secrets

	$(INSTALL_DATA) ./files/libreswan.uci $(1)/etc/config/libreswan

	$(INSTALL_DATA) ./files/default.hotplug $(1)/etc/hotplug.d/libreswan/00-default
	$(INSTALL_DATA) ./files/user.hotplug $(1)/etc/hotplug.d/libreswan/01-user
	$(INSTALL_DATA) ./files/vti.hotplug $(1)/etc/hotplug.d/libreswan/02-vti
	$(INSTALL_DATA) ./files/iptables.hotplug $(1)/etc/hotplug.d/libreswan/61-iptables

	$(INSTALL_BIN) ./files/libreswan.rpcd $(1)/usr/libexec/rpcd/libreswan
endef

$(eval $(call BuildPackage,libreswan))
