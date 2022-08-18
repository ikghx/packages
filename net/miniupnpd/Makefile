#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=miniupnpd
PKG_VERSION:=2.3.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/miniupnp/miniupnp.git
PKG_SOURCE_DATE:=2022-08-06
PKG_SOURCE_VERSION:=fa42d8f9316bf9c1ca14317e5a6e0d4a21365629
PKG_MIRROR_HASH:=06662c7cf8f553f625cd968d12ea732db4193706510ed0db6e8bdd1c6b935c50
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_DATE)/$(PKG_NAME)/miniupnpd

PKG_MAINTAINER:=
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:miniupnp_project:miniupnpd

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/version.mk

TAR_OPTIONS+= --strip-components 1
TAR_CMD=$(HOST_TAR) -C $(1)/.. $(TAR_OPTIONS)

define Package/miniupnpd
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:= \
	+IPV6:ip6tables \
	+IPV6:libip6tc \
	+iptables \
	+libcap-ng \
	+libip4tc \
	+libmnl \
	+libnetfilter-conntrack \
	+libuuid
  TITLE:=Lightweight UPnP IGD, NAT-PMP & PCP daemon
  SUBMENU:=Firewall
  URL:=https://miniupnp.tuxfamily.org/
endef

define Package/miniupnpd/conffiles
/etc/config/upnpd
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	echo "$(VERSION_NUMBER)" | tr '() ' '_' >$(PKG_BUILD_DIR)/os.openwrt
endef

CONFIGURE_ARGS = \
	$(if $(CONFIG_IPV6),--ipv6) \
	--igd2 \
	--leasefile \
	--portinuse \
	--firewall=iptables \
	--disable-fork

TARGET_CFLAGS += $(FPIC) -flto
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed

define Package/miniupnpd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/usr/share/miniupnpd

	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/miniupnpd $(1)/usr/sbin/miniupnpd
	$(INSTALL_BIN) ./files/miniupnpd.init $(1)/etc/init.d/miniupnpd
	$(INSTALL_CONF) ./files/upnpd.config $(1)/etc/config/upnpd
	$(INSTALL_DATA) ./files/miniupnpd.hotplug $(1)/etc/hotplug.d/iface/50-miniupnpd
	$(INSTALL_BIN) ./files/miniupnpd.defaults $(1)/etc/uci-defaults/99-miniupnpd
	$(INSTALL_DATA) ./files/firewall.include $(1)/usr/share/miniupnpd/firewall.include
endef

$(eval $(call BuildPackage,miniupnpd))
