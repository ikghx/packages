# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=gmediarender
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/hzeller/gmrender-resurrect.git
PKG_SOURCE_DATE:=2022-09-24
PKG_SOURCE_VERSION:=2a4d744814e3c824efa8665d91bffa6696836f43
PKG_MIRROR_HASH:=edf1784ca02ce706824f38836bc0b8d4b6fbf355a1160f0c9d4eb4f6aecb4002

PKG_REMOVE_FILES:=autogen.sh aclocal.m4
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/gmediarender
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+glib2 +gstreamer1 +gstreamer1-plugins-base +gst1-plugins-base +gst1-plugins-good +gst1-plugins-bad +libupnp
  TITLE:=A Headless UPnP media Renderer
endef

define Package/gmediarender/description
  gmediarender implements the server component that provides UPnP
  controllers a means to render media content (audio, video and images)
  from a UPnP media server.
endef

CONFIGURE_ARGS+= \
	CFLAGS="$(TARGET_CFLAGS) -std=gnu99" \
	--with-build-cc="$(HOSTCC)" \
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
