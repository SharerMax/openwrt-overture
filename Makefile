#
# Copyright (C) 2020 SharerMax
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=overture
PKG_VERSION:=1.6-rc9
PKG_RELEASE:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/shawn1m/overture/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=187725358c90bbf0380cb2c3246072baae77ea93a94ea17072ba26f0a24d5be7

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=shawn1m <https://github.com/shawn1m>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/shawn1m/overture
GO_PKG_LDFLAGS:=-s -w

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Overture is a DNS server/forwarder/dispatcher written in Go.
	URL:=https://github.com/shawn1m/overture
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-certificates
endef

define Package/$(PKG_MAME)/description
	Overture means an orchestral piece at the beginning of a classical music composition, just like DNS which is nearly the first step of surfing the Internet.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/main $(1)/usr/bin/$(PKG_NAME)
endef
$(eval $(call GoBinPackage,overture))
$(eval $(call BuildPackage,overture))
