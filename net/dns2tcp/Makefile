include $(TOPDIR)/rules.mk

PKG_NAME:=dns2tcp
PKG_VERSION:=1.1.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/zfl9/dns2tcp.git
PKG_SOURCE_DATE:=2020-05-05
PKG_SOURCE_VERSION:=10ed687778f18d1b9c98bb51187a3a9086d3a0d9
PKG_MIRROR_HASH:=bb40f027fef8534b0f905a827dbc3cc613fd06b705392148a12b80e1f9570a88

PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=pexcn <i@pexcn.me>

include $(INCLUDE_DIR)/package.mk

define Package/dns2tcp
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Utility to convert DNS query from UDP to TCP
  URL:=https://github.com/zfl9/dns2tcp
endef

define Package/dns2tcp/description
Utility to convert DNS query from UDP to TCP.
endef

define Package/dns2tcp/conffiles
/etc/config/dns2tcp
endef

define Package/dns2tcp/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dns2tcp $(1)/usr/bin
endef

$(eval $(call BuildPackage,dns2tcp))
