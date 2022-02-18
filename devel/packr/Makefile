#
# Copyright (C) 2020 Jeffery To
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=packr
PKG_VERSION:=2.8.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/gobuffalo/packr/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=67352bb3a73f6b183d94dd94f1b5be648db6311caa11dcfd8756193ebc0e2db9

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.txt
PKG_MAINTAINER:=Jeffery To <jeffery.to@gmail.com>

HOST_BUILD_DEPENDS:=golang/host
HOST_BUILD_PARALLEL:=1

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/gobuffalo/packr
GO_PKG_BUILD_PKG:=github.com/gobuffalo/packr/v2/packr2

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include ../../lang/golang/golang-host-build.mk
include ../../lang/golang/golang-package.mk

define Package/packr
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=Embed static files into Go binaries
  URL:=https://github.com/gobuffalo/packr
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/packr/description
  Packr is a simple solution for bundling static assets inside of Go
  binaries. Most importantly it does it in a way that is friendly to
  developers while they are developing.
endef

$(eval $(call GoBinHostBuild))
$(eval $(call HostBuild))
$(eval $(call GoBinPackage,packr))
$(eval $(call BuildPackage,packr))
