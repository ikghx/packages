include $(TOPDIR)/rules.mk

PKG_NAME:=udpxy
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pcherenkov/udpxy
PKG_SOURCE_DATE:=2024-03-03
PKG_SOURCE_VERSION:=23b434374d76e5de74138d44cbb8bda1b32dcfe0
PKG_MIRROR_HASH:=2961a022c4588c32ad145c19ad6b87b02cdc7eda14e01c9345f982d442776dce

PKG_MAINTAINER:=Álvaro Fernández Rojas <noltari@gmail.com>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=chipmunk/gpl.txt

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

MAKE_PATH:=chipmunk

define Package/udpxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Convert UDP IPTV streams into HTTP streams
  URL:=https://github.com/pcherenkov/udpxy
endef

define Package/udpxy/description
	udproxy makes it possible to convert UDP IPTV streams into HTTP
	streams which can be viewed even over WLANs. HTTP streams do
	not generate huge amounts of multicast traffic, so a sd stream
	only takes about 300k. Interesting for peoply who have IPTV at
	home and do not want to rent multiple decoders from their
	provider but just use their own streaming client (for example
	popcornhour/mediatomb/vlc).
endef

define Package/udpxy/conffiles
/etc/config/udpxy
endef

MAKE_FLAGS += \
	INSTALLROOT="$(PKG_INSTALL_DIR)/usr" \
	ALL_CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)"

define Package/udpxy/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/etc/config
	$(INSTALL_CONF) ./files/udpxy.conf $(1)/etc/config/udpxy
	$(INSTALL_BIN) ./files/udpxy.init $(1)/etc/init.d/udpxy
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/udpxy $(1)/usr/bin/
	ln -sf udpxy $(1)/usr/bin/udpxrec
endef

$(eval $(call BuildPackage,udpxy))
