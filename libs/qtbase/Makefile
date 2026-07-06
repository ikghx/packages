# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2017-2023 bishuiwuhen

include $(TOPDIR)/rules.mk

PKG_NAME:=qtbase
PKG_BASE:=6.10
PKG_BUGFIX:=3
PKG_VERSION:=$(PKG_BASE).$(PKG_BUGFIX)
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-everywhere-src-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:= \
	https://download.qt.io/official_releases/qt/$(PKG_BASE)/$(PKG_VERSION)/submodules/ \
	https://master.qt.io/archive/qt/$(PKG_BASE)/$(PKG_VERSION)/submodules/
PKG_HASH:=383dc907816338f0cba72088a524c07458dfc69ce684ca9132fcc4fe91c24b0b

HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-everywhere-src-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-everywhere-src-$(PKG_VERSION)

PKG_BUILD_DEPENDS:=qtbase/host

HOST_BUILD_PARALLEL:=1
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

PKG_LICENSE:=LGPL-3.0-only
PKG_LICENSE_FILES:=LICENSES/LGPL-3.0-only.txt
PKG_CPE_ID:=cpe:/a:qt:qt

CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/qtbase/Default
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Qt6
  TITLE:=qtbase
  URL:=http://qt-project.org
  DEPENDS:=+libgcc +libstdcpp
endef

define Package/qtbase/description
  This package provides the Qt6 libraries.

  Qt is a cross-platform application development framework for desktop, embedded and mobile.
  Supported Platforms include Linux, OS X, Windows, VxWorks, QNX, Android, iOS, BlackBerry,
  Sailfish OS and others.

  Qt is not a programming language on its own. It is a framework written in C++.

  This package provides the following run-time libraries:
  - core
  - network
  - xml
  - sql
  - concurrent
endef

define Package/qtbase
  $(call Package/qtbase/Default)
  HIDDEN:=1
endef

# Can be removed if glibc version> 2.34
ifdef CONFIG_USE_GLIBC
  TARGET_LDFLAGS += -ldl -lrt -lpthread
endif

TARGET_LDFLAGS += -Wl,--as-needed

CMAKE_SHARED_LDFLAGS:=$(filter-out -Wl$(comma)-Bsymbolic-functions,$(CMAKE_SHARED_LDFLAGS))

CMAKE_HOST_OPTIONS += \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_SHARED_LIBS=OFF \
	-DQT_FEATURE_concurrent=ON \
	-DQT_FEATURE_dbus=OFF \
	-DQT_FEATURE_gui=OFF \
	-DQT_FEATURE_optimize_size=ON \
	-DQT_FEATURE_sql=OFF \
	-DQT_FEATURE_testlib=OFF \
	-DQT_FEATURE_zstd=OFF \
	-DQT_FEATURE_glib=OFF \
	-DQT_FEATURE_icu=OFF \
	-DQT_FEATURE_brotli=OFF \
	-DQT_FEATURE_androiddeployqt=OFF \
	-DQT_FEATURE_macdeployqt=OFF \
	-DQT_FEATURE_windeployqt=OFF \
	-DQT_FEATURE_wayland=OFF \
	-DQT_FEATURE_qtwaylandscanner=OFF \
	-DINPUT_libb2=no \
	-DINPUT_openssl=no \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

CMAKE_OPTIONS += \
	-DINSTALL_ARCHDATADIR=/usr/share/Qt6 \
	-DINSTALL_DATADIR=/usr/share/Qt6 \
	-DQT_HOST_PATH=$(STAGING_DIR_HOSTPKG) \
	-DQT_QMAKE_TARGET_MKSPEC=devices/linux-generic-g++ \
	-DQT_QMAKE_DEVICE_OPTIONS=CROSS_COMPILE="$(TARGET_CROSS);COMPILER_FLAGS=$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS);LINKER_FLAGS=$(TARGET_LDFLAGS) $(EXTRA_LDFLAGS)" \
	-DBUILD_SHARED_LIBS=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON \
	-DCMAKE_SKIP_RPATH=TRUE \
	-DQT_FEATURE_concurrent=ON \
	-DQT_FEATURE_dbus=OFF \
	-DQT_FEATURE_gui=OFF \
	-DQT_FEATURE_libudev=OFF \
	-DQT_FEATURE_optimize_size=ON \
	-DQT_FEATURE_printsupport=OFF \
	-DQT_FEATURE_testlib=OFF \
	-DQT_FEATURE_thread=ON \
	-DQT_FEATURE_widgets=OFF \
	-DQT_FEATURE_zstd=OFF \
	-DQT_FEATURE_system_zlib=ON \
	-DQT_FEATURE_wayland=OFF \
	-DQT_FEATURE_qtwaylandscanner=OFF \
	-DQT_FEATURE_opengl=OFF \
	-DQT_FEATURE_egl=OFF \
	-DINPUT_doubleconversion=qt \
	-DINPUT_pcre2=system \
	-DQT_FEATURE_glib=OFF \
	-DQT_FEATURE_icu=OFF \
	-DQT_FEATURE_mimetype=ON \
	-DQT_FEATURE_permissions=OFF \
	-DQT_FEATURE_network=ON \
	-DQT_FEATURE_openssl=ON \
	-DQT_FEATURE_openssl_linked=ON \
	-DINPUT_openssl=linked \
	-DQT_FEATURE_libproxy=OFF \
	-DQT_FEATURE_gssapi=OFF \
	-DQT_FEATURE_sql=ON \
	-DQT_FEATURE_system_sqlite=ON \
	-DQT_FEATURE_sql_sqlite=ON \
	-DQT_FEATURE_sql_db2=OFF \
	-DQT_FEATURE_sql_ibase=OFF \
	-DQT_FEATURE_sql_mysql=OFF \
	-DQT_FEATURE_sql_oci=OFF \
	-DQT_FEATURE_sql_odbc=OFF \
	-DQT_FEATURE_sql_psql=OFF \
	-DQT_FEATURE_sql_mimer=OFF \
	-DQT_FEATURE_xml=ON \
	-DQT_FEATURE_xkbcommon=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF \
	-DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING=OFF

define Package/qtbase/Default/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libQt6$(shell echo $(2) | sed -e 's/\b[[:alpha:]]/\u&/g').so* $(1)/usr/lib
endef

# 1: library short name
# 2: dependencies on other qtbase libraries (short name)
# 3: dependencies on other packages
define DefineQtbaseLibrary
  QTBASE_LIBS+=$(1)

  define Package/libqt6$(1)
    $(call Package/qtbase/Default)
    TITLE+=$(1) library
    DEPENDS+=$(foreach lib,$(2),+libqt6$(lib)) $(3)
    ABI_VERSION:=6
    HIDDEN:=1
  endef

  define Package/libqt6$(1)/description
    This package contains the qtbase $(1) library.
  endef

  define Package/libqt6$(1)/install
    $(call Package/qtbase/Default/install,$$(1),$(1))
  endef
endef

$(eval $(call DefineQtbaseLibrary,core,,+libatomic +libpcre2-16 +zlib))
$(eval $(call DefineQtbaseLibrary,network,core,+libopenssl +zlib))
$(eval $(call DefineQtbaseLibrary,xml,core,))
$(eval $(call DefineQtbaseLibrary,sql,core,+libsqlite3))
$(eval $(call DefineQtbaseLibrary,concurrent,core,))

define Package/qtbase/Plugins/install
	$(INSTALL_DIR) $(1)/usr/share/Qt6/plugins/$(2)
	$(CP) $(PKG_INSTALL_DIR)/usr/share/Qt6/plugins/$(2)/lib$(3).so $(1)/usr/share/Qt6/plugins/$(2)
endef

# 1: plugin directory
# 2: plugin short name
# 3: so file name
# 4: dependencies on other qtbase libraries (short name)
# 5: dependencies on other packages
define DefineQtbasePlugin
  $(call DefineQtbaseLibrary,$(2),$(4),$(5))

  define Package/libqt6$(2)/install
    $(call Package/qtbase/Plugins/install,$$(1),$(1),$(3))
  endef
endef

$(eval $(call DefineQtbasePlugin,sqldrivers,sql-sqlite,qsqlite,core sql,+libpcre2-16 +zlib +libsqlite3))
$(eval $(call DefineQtbasePlugin,tls,network-tlsbackend-openssl,qopensslbackend,core network,+libopenssl +libpcre2-16 +zlib))

$(foreach lib,$(QTBASE_LIBS),$(eval $(call BuildPackage,libqt6$(lib))))
$(eval $(call HostBuild))
$(eval $(call BuildPackage,qtbase))
