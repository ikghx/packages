include $(TOPDIR)/rules.mk

PKG_NAME:=kcptun
PKG_VERSION:=20221008
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/xtaci/kcptun/tar.gz/v${PKG_VERSION}?
PKG_SOURCE_DATE:=2022-06-28
PKG_HASH:=a52dcbe336a27c256a4f25ceed5961754ea584a899b92757c54e7bac25d5efae

PKG_MAINTAINER:=Dengfeng Liu <liudf0716@gmail.com>, Chao Liu <expiron18@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/xtaci/kcptun

GO_PKG_LDFLAGS_X:=main.VERSION=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include ../../lang/golang/golang-package.mk

define Package/kcptun-config/conffiles
/etc/config/kcptun
endef

define Package/kcptun/Default
  define Package/kcptun-$(1)
    SECTION:=net
    CATEGORY:=Network
    SUBMENU:=Web Servers/Proxies
    DEPENDS:=$$(GO_ARCH_DEPENDS)
    TITLE:=KCP-based Secure Tunnel $(1)
    URL:=https://github.com/xtaci/kcptun
  endef

  define Package/kcptun-$(1)/description
    kcptun is a Stable & Secure Tunnel Based On KCP with N:M Multiplexing.
This package only contains kcptun $(1).
  endef

  define Package/kcptun-$(1)/install
	$$(call GoPackage/Package/Install/Bin,$$(PKG_INSTALL_DIR))

	$$(INSTALL_DIR) $$(1)/usr/bin
	$$(INSTALL_BIN) $$(PKG_INSTALL_DIR)/usr/bin/$(1) $$(1)/usr/bin/kcptun-$(1)
  endef
endef

KCPTUN_COMPONENTS:=server client
$(foreach component,$(KCPTUN_COMPONENTS), \
  $(eval $(call Package/kcptun/Default,$(component))) \
  $(eval $(call GoBinPackage,kcptun-$(component))) \
  $(eval $(call BuildPackage,kcptun-$(component))) \
)
