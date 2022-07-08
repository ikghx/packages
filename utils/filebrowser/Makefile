#
# Copyright (C) 2021 ImmortalWrt
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE.txt for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=filebrowser
PKG_VERSION:=2.22.3
PKG_RELEASE:=1

PKG_SOURCE:=filebrowser-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/filebrowser/filebrowser/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=d1108dd89a1f9287cd3b757851921363ec2cae7cd10dfb7f0c82c4b81e1ca285

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=CN_SZTL <cnsztl@immortalwrt.org>

PKG_BUILD_DEPENDS:=golang/host node/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/filebrowser/filebrowser
GO_PKG_LDFLAGS_X:= \
	$(GO_PKG)/v2/version.CommitSHA=$(PKG_SOURCE_VERSION) \
	$(GO_PKG)/v2/version.Version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/filebrowser
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Web File Browser
  URL:=https://github.com/filebrowser/filebrowser
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/filebrowser/description
  filebrowser provides a file managing interface within a specified directory
  and it can be used to upload, delete, preview, rename and edit your files.
  It allows the creation of multiple users and each user can have its own directory.
  It can be used as a standalone app or as a middleware.
endef

define Build/Compile
	( \
		pushd "$(PKG_BUILD_DIR)/frontend" ; \
		npm ci; \
		npm run lint ; \
		npm run build ; \
		popd ; \
		$(call GoPackage/Build/Compile) ; \
	)
endef

define Package/filebrowser/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/etc/config/ $(1)/etc/init.d/ $(1)/usr/bin/
	$(INSTALL_CONF) $(CURDIR)/files/filebrowser.config $(1)/etc/config/filebrowser
	$(INSTALL_BIN) $(CURDIR)/files/filebrowser.init $(1)/etc/init.d/filebrowser
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/filebrowser $(1)/usr/bin/filebrowser
endef

$(eval $(call GoBinPackage,filebrowser))
$(eval $(call BuildPackage,filebrowser))
