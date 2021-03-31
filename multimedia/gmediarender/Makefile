#
# Copyright (C) 2020 coolsnowwolf@gmail.com
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gmediarender
PKG_VERSION:=0.0.9
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/hzeller/gmrender-resurrect.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=4ac7d8914dc089651ae9d6c421ecda8f4d0ab5e3
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz
PKG_MIRROR_HASH:=f910daccaaa23c6ed20d4865ab0485c577fc1e43007ad1932ceaf2872dcbca39

PKG_FIXUP:=autoreconf
PKG_INSTALL=1
PKG_REMOVE_FILES:=autogen.sh aclocal.m4

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/gmediarender
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+gstreamer1 +gstreamer1-plugins-base +gst1-plugins-base +gst1-plugins-good +gst1-plugins-bad +libupnp
  TITLE:=A Headless UPnP media Renderer
endef

define Package/gmediarender/description
  gmediarender implements the server component that provides UPnP
  controllers a means to render media content (audio, video and images)
  from a UPnP media server.
endef

CONFIGURE_ARGS+= \
	CFLAGS="$(TARGET_CFLAGS) -std=gnu99" --with-build-cc="$(HOSTCC)" \
	--prefix="\usr"

define Package/gmediarender/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/gmediarender $(1)/usr/bin/gmediarender
	$(INSTALL_DIR) $(1)/usr/share/gmediarender
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/share/gmediarender/*.png $(1)/usr/share/gmediarender
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/gmediarender.config $(1)/etc/config/gmediarender
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/gmediarender.init $(1)/etc/init.d/gmediarender
endef

$(eval $(call BuildPackage,gmediarender))
