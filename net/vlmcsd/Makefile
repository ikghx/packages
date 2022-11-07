include $(TOPDIR)/rules.mk

PKG_NAME:=vlmcsd
PKG_VERSION:=svn1113
PKG_RELEASE:=1

PKG_MAINTAINER:=fuyumi <280604399@qq.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Wind4/vlmcsd.git
PKG_SOURCE_VERSION:=65228e5c7916acd947ffb53be18abadafbc1be56
PKG_MIRROR_HASH:=52c402278f9968af3fbb5dcbaf267fd39675f316c774058bcdadf3ca5992b7b4

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR)-$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vlmcsd
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A KMS Emulator in C
	URL:=https://github.com/Wind4/vlmcsd
	DEPENDS:=+libpthread
endef

define Package/vlmcsd/description
	KMS Emulator in C (currently runs on Linux including Android, FreeBSD,
	Solaris, Minix, Mac OS, iOS, Windows with or without Cygwin)
endef

define Package/vlmcsd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcsd $(1)/usr/bin/vlmcsd
	#$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcs $(1)/usr/bin/vlmcs
endef

$(eval $(call BuildPackage,vlmcsd))
