include $(TOPDIR)/rules.mk

PKG_NAME:=openclash-meta
PKG_BASE_VERSION:=alpha
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
# PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-g$(PKG_REV).tar.gz
PKG_SOURCE_URL:=https://github.com/MetaCubeX/mihomo.git
PKG_SOURCE_VERSION:=8861eaf9033db6d1db2da5f59962770884f92013
PKG_MIRROR_HASH:=5fc0c6b2c193310e72943bf742b62d61e03d405a188d0ff7874e71e192abb3b9

# PKG_REV:=$(shell git rev-parse --short=7 HEAD)
PKG_REV:=$(shell echo $(PKG_SOURCE_VERSION) | cut -c1-7)
PKG_VERSION:=$(PKG_BASE_VERSION)-$(call version_abbrev,$(PKG_SOURCE_VERSION))

PKG_MAINTAINER:=EkkoG <beijiu572@gmail.om>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

# PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-g$(PKG_REV)
PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/metacubex/mihomo
GO_PKG_BUILD_PKG:=$(GO_PKG)
GO_PKG_LDFLAGS:= -s -w
GO_PKG_LDFLAGS_X:= \
	$(GO_PKG)/constant.Version=$(PKG_BASE_VERSION)-g$(PKG_REV)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/../feeds/packages/lang/golang/golang-package.mk

# TAR_OPTIONS+= --strip-components 1
# TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)

define Package/$(PKG_NAME)/template
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
endef

define Package/$(PKG_NAME)
	$(call Package/$(PKG_NAME)/template)
	TITLE:=A rule-based tunnel in Go
	URL:=https://github.com/MetaCubeX/Clash.Meta
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/$(PKG_NAME)/description
	Clash, A rule based tunnel in Go, support VMess, Shadowsocks,
	Trojan, Snell protocol for remote connections.
endef

define Package/$(PKG_NAME)/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/etc/openclash/core
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mihomo $(1)/etc/openclash/core/clash_meta
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
