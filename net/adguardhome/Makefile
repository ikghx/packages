# Copyright (C) 2020 xiaorouji
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=AdGuardHome
PKG_VERSION:=0.105.2
PKG_RELEASE:=1

PKG_SOURCE_FOOTER:=tar.gz
PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)/
PKG_SOURCE:=dummy
PKG_HASH:=dummy

ifeq ($(ARCH),i386)
  PKG_ARCH:=386
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=318e0538386e52025448e7dc1e67b71bd399981e386ba0a54802ff3c13b25016
endif

ifeq ($(ARCH),x86_64)
  PKG_ARCH:=amd64
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=8b89b9e2d1483f3830adb4b5166db47c733d10fb288c57003c5eb7f899c7eabe
endif

ifeq ($(ARCH),kirkwood)
  PKG_ARCH:=armv5
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=d5cb77590d4b1a12747c0203b59a5d6176f41cc3feec7a35d51aaf044f4881f9
endif

ifeq ($(ARCH),bcm53xx)
  PKG_ARCH:=armv6
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=98a1f09b44ac1011b6b9f015d2b04787603b4e875a1cf1dd1823b93bb53c34ce
endif

ifeq ($(ARCH),arm)
  ARM_CPU_FEATURES:=$(word 2,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))
  ifeq ($(ARM_CPU_FEATURES),)
  PKG_ARCH:=armv5
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=d5cb77590d4b1a12747c0203b59a5d6176f41cc3feec7a35d51aaf044f4881f9
  else
  PKG_ARCH:=armv7
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=92347fecc69c38fe58cd96fe2d9565ca92ef03f947c223ee938ae44c5ed5fdb8
endif
endif

ifeq ($(ARCH),arm64)
  PKG_ARCH:=arm64
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=4f3ecccc4cd3042efcd648425a58b29c1fa2c0910dfc8cd17acdb0fab3031d7b
endif

ifeq ($(ARCH),aarch64)
  PKG_ARCH:=arm64
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=4f3ecccc4cd3042efcd648425a58b29c1fa2c0910dfc8cd17acdb0fab3031d7b
endif

ifeq ($(ARCH),mips)
  PKG_ARCH:=mips_softfloat
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=4d7b16970c76d833c57524d249443c26b9566d89fdba82ecb112a390c4e12c9f
endif

ifeq ($(ARCH),mipsel)
  PKG_ARCH:=mipsle_softfloat
  PKG_SOURCE:=$(PKG_NAME)_linux_$(PKG_ARCH).$(PKG_SOURCE_FOOTER)
  PKG_HASH:=db1f40bbbff094131504e21726fa74d07a96c5cf1c0d03b41b2e5738e05801e5
endif

PKG_CONFIG_DEPENDS:= \
	CONFIG_ADGUARDHOME_COMPRESS_UPX

include $(INCLUDE_DIR)/package.mk

TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)

define Package/AdGuardHome
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Network-wide ads & trackers blocking DNS server
	URL:=https://github.com/AdguardTeam/AdGuardHome
	DEPENDS:=+ca-bundle
endef

define Package/AdGuardHome/description
Free and open source, powerful network-wide ads and trackers blocking DNS server.
endef

define Package/AdGuardHome/config
	config ADGUARDHOME_COMPRESS_UPX
		bool "Compress executable files with UPX"
		default y
endef

define Build/Configure
endef

define Build/Compile
	true
ifeq ($(CONFIG_ADGUARDHOME_COMPRESS_UPX),y)
	upx --lzma --best $(PKG_BUILD_DIR)/AdGuardHome/AdGuardHome
endif
endef

define Package/AdGuardHome/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/AdGuardHome/AdGuardHome $(1)/usr/bin/AdGuardHome
endef

$(eval $(call BuildPackage,AdGuardHome))
