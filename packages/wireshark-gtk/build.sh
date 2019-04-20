TERMUX_PKG_HOMEPAGE=https://www.wireshark.org/
TERMUX_PKG_DESCRIPTION="Network protocol analyzer"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
TERMUX_PKG_VERSION=2.6.7
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://www.wireshark.org/download/src/wireshark-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=747b3e7a37414942959f76f198be49dcbcca936bda538c4408942ce71bfd2b71

TERMUX_PKG_DEPENDS="atk, c-ares, desktop-file-utils, gdk-pixbuf, glib, gtk3, hicolor-icon-theme, krb5, libandroid-shmem, libcairo-x, libgcrypt, libgnutls, libgpg-error, liblua52, liblz4, libmaxminddb, libnghttp2, libnl, libpcap, libssh, libxml2, pango-x, zlib"
TERMUX_PKG_CONFLICTS="tshark, wireshark, wireshark-cli"
TERMUX_PKG_PROVIDES="tshark, wireshark, wireshark-cli"
TERMUX_PKG_REPLACES="tshark, wireshark, wireshark-cli"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-gtk=3 --with-qt=no"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	export CFLAGS=$(echo $CFLAGS | sed 's@-Oz@-Os@g')
	export LIBS=" -landroid-shmem"
}

termux_step_post_configure() {
	## prebuild libwsutil & libwscodecs for target (needed for plugins/codecs/l16_mono)
	cd ./wsutil && {
		make
		cd -
	}
	cd ./codecs && {
		make
		cd -
	}
}
