include $(TOPDIR)/rules.mk

PKG_NAME:=transmission-web-control
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ronggang/transmission-web-control
PKG_SOURCE_DATE:=2023-05-22
PKG_SOURCE_VERSION:=5aeb20c141f6c1ca30c0aaae6b861471a48210d8
PKG_MIRROR_HASH:=929bfeea8fcd7682d3e5cf332115b7a8324cfe0d36a9acd837eb1dd6cb40a07e

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Richard Yu <yurichard3839@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/transmission-web-control
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=BitTorrent
  DEPENDS:=+transmission-daemon
  CONFLICTS:=transmission-web
  TITLE:=Transmission Web Control
  URL:=https://github.com/ronggang/transmission-web-control
  PKGARCH:=all
endef

define Package/transmission-web-control/description
 Transmission Web Control is a custom Web UI for Transmission.
endef

define Build/Compile
endef

define Package/transmission-web-control/install
	$(INSTALL_DIR) $(1)/usr/share/transmission/web
	$(CP) $(PKG_BUILD_DIR)/src/* $(1)/usr/share/transmission/web
endef

$(eval $(call BuildPackage,transmission-web-control))
