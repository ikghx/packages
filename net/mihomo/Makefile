include $(TOPDIR)/rules.mk

PKG_NAME:=mihomo
PKG_VERSION:=1.19.31

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/MetaCubeX/mihomo/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=5a04aa9cf4520e06fa1c13d37b6aca49209479690722d485c40034ab17f8581f

PKG_LICENSE:=GPL3.0+
PKG_MAINTAINER:=Joseph Mory <morytyann@gmail.com>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/metacubex/mihomo
GO_PKG_BUILD_PKG:=github.com/metacubex/mihomo
GO_PKG_LDFLAGS_X:=$(GO_PKG)/constant.Version=$(PKG_BUILD_VERSION) $(GO_PKG)/constant.BuildTime=$(PKG_BUILD_TIME)
GO_PKG_TAGS:=with_gvisor
GO_PKG_INSTALL_BIN_PATH:=/usr/libexec

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/mihomo
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A rule based proxy in Go.
  URL:=https://wiki.metacubex.one
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle +ip-full +kmod-inet-diag +kmod-tun
  ALTERNATIVES:=\
    300:/usr/bin/mihomo:/usr/libexec/mihomo
endef

define Package/mihomo/description
  A rule based proxy in Go.
endef

define Package/mihomo/install
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/openclash/core
	$(LN) /usr/libexec/mihomo $(1)/etc/openclash/core/clash_meta
endef

define Build/Prepare
	$(Build/Prepare/Default)
	$(RM) -r $(PKG_BUILD_DIR)/rules/logic_test
endef

$(eval $(call GoBinPackage,mihomo))
$(eval $(call BuildPackage,mihomo))
