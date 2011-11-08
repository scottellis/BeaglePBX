#############################################################
#
# X-Loader
#
#############################################################
X_LOADER_RAW_VERSION = $(call qstrip,$(BR2_TARGET_XLOADER_VERSION))
X_LOADER_SITE = git://gitorious.org/x-loader/x-loader.git
X_LOADER_LIBTOOL_PATCH = NO
X_LOADER_INSTALL_STAGING = NO

X_LOADER_BOARD_NAME = $(call qstrip,$(BR2_TARGET_XLOADER_BOARDNAME))

ifeq ($(X_LOADER_RAW_VERSION),1.51)
X_LOADER_VERSION=v1.5.1
endif

define X_LOADER_CONFIGURE_CMDS
	$(TARGET_CONFIGURE_OPTS) \
	$(X_LODER_CONFIGURE_OPTS) \
	$(MAKE) -C $(X_LOADER_DIR) \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	$(X_LOADER_BOARD_NAME)_config
	touch $@
endef

X_LOADER_MLO=MLO
X_LOADER_SIGNGP=signGP

define X_LOADER_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) \
		$(X_LOADER_CONFIGURE_OPTS) \
		EXTRAVERSION="$(BR2_TARGET_XLOADER_EXTRAVERSION)" \
		$(MAKE) CROSS_COMPILE="$(CCACHE) $(TARGET_CROSS)" \
		$(X_LOADER_MAKE_OPT) -C $(X_LOADER_DIR)
	(cd $(X_LOADER_DIR); ./$(X_LOADER_SIGNGP))
	/bin/mv $(X_LOADER_DIR)/x-load.bin.ift $(X_LOADER_DIR)/$(X_LOADER_MLO)
endef

# Copy the result to the images/ directory
define X_LOADER_INSTALL_TARGET_CMDS
	rm -f $(BINARIES_DIR)/$(X_LOADER_MLO)
	cp -dpf $(X_LOADER_DIR)/$(X_LOADER_MLO) $(BINARIES_DIR)/
endef

$(eval $(call AUTOTARGETS,boot,x-loader))

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_TARGET_XLOADER),y)
TARGETS+=x-loader

# we NEED a board name unless we're at make source
ifeq ($(filter source,$(MAKECMDGOALS)),)
ifeq ($(X_LOADER_BOARD_NAME),)
$(error NO X-Loader board name set. Check your BR2_TARGET_XLOADER_BOARDNAME setting)
endif
endif

endif
