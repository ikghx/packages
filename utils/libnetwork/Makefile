include $(TOPDIR)/rules.mk

PKG_NAME:=libnetwork
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

GO_PKG:=github.com/docker/libnetwork
GO_PKG_BUILD_PKG:= \
  $(GO_PKG)/cmd/proxy \
  $(GO_PKG)/cmd/dnet

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(GO_PKG)
PKG_SOURCE_VERSION:=05b93e0d3a95952f70c113b0bc5bdb538d7afdd7
PKG_SOURCE_DATE:=2023-01-18
PKG_MIRROR_HASH:=b4c640228a590a0cf54ce208c37ae5ce379d5f5b34d99f89b42411113450f63c

PKG_MAINTAINER:=Gerard Ryan <G.M0N3Y.2503@gmail.com>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include ../../lang/golang/golang-package.mk

define Package/libnetwork
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=networking for containers
  URL:=https://github.com/docker/libnetwork
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/libnetwork/description
Libnetwork provides a native Go implementation for connecting containers.
The goal of libnetwork is to deliver a robust Container Network Model that provides a consistent programming interface and the required network abstractions for applications.
endef

GO_PKG_BUILD_VARS += GO111MODULE=auto

define Package/libnetwork/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))

	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/dnet $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/proxy $(1)/usr/bin/docker-proxy
endef

$(eval $(call GoBinPackage,libnetwork))
$(eval $(call BuildPackage,libnetwork))
