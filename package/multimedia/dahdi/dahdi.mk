#############################################################
#
# Dahdi
#
##############################################################
DAHDI_VERSION = 2.5.0+2.5.0
DAHDI_SOURCE= dahdi-linux-complete-$(DAHDI_VERSION).tar.gz
DAHDI_SITE = http://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/releases
DAHDI_DIR = $(BUILD_DIR)/dahdi-$(ASTERISK_VERSION)
#DAHDI_BINARY = asterisk
#DAHDI_TARGET_BINARY = usr/sbin/asterisk
#DAHDI_CONF_OPT = --without-sqlite3 --disable-xmldoc
DAHDI_DEPENDENCIES = libxml2

$(eval $(call AUTOTARGETS,package,dahdi))
