include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=usb-serial-xr_usb_serial_common
PKG_VERSION:=1a
PKG_RELEASE=1

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_SOURCE_URL:=https://github.com/kasbert/epsolar-tracer
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=8c21f4afdfd6acd77b6adad59a4dabe5cbf2b947
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz
PKG_MIRROR_HASH:=ecf7df24349919615328de49589de0750f5cbece3fb7d4a919ff90b724324a08

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define KernelPackage/usb-serial-xr_usb_serial_common
	SECTION:=kernel
	CATEGORY:=Kernel modules
	SUBMENU:=USB Support
	TITLE:=Support for Exar USB to RS-485/RS-422
	URL:=https://www.exar.com/content/document.ashx?id=21651
	FILES:=$(PKG_BUILD_DIR)/xr_usb_serial_common-1a/xr_usb_serial_common.$(LINUX_KMOD_SUFFIX)
	AUTOLOAD:=$(call AutoProbe,xr_usb_serial_common)
	DEPENDS+=kmod-usb-serial
endef

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
		ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		SUBDIRS="$(PKG_BUILD_DIR)/xr_usb_serial_common-1a" \
		modules
endef

$(eval $(call KernelPackage,usb-serial-xr_usb_serial_common))
