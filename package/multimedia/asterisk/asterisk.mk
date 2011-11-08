#############################################################
#
# asterisk
#
##############################################################
ASTERISK_VERSION = 1.8.7.0
ASTERISK_SOURCE= asterisk-$(ASTERISK_VERSION).tar.gz
ASTERISK_SITE = http://downloads.asterisk.org/pub/telephony/asterisk/releases
ASTERISK_DIR = $(BUILD_DIR)/asterisk-$(ASTERISK_VERSION)
ASTERISK_BINARY = asterisk
ASTERISK_TARGET_BINARY = usr/sbin/asterisk
ASTERISK_CONF_OPT = --without-sqlite3 --disable-xmldoc
#ASTERISK_CONF_OPT = --without-sqlite3 --with-libxml2=/opt/buildroot/output/staging/usr/include/libxml2/libxml
ASTERISK_DEPENDENCIES = libxml2

$(eval $(call AUTOTARGETS,package,asterisk))
