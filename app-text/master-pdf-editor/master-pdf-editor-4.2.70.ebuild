# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

# get the major version from PV
MV=${PV:0:1}

DESCRIPTION="Master PDF Editor is the optimal solution for editing PDF files in Linux. It enables you to create, edit, view, encrypt, sign and print interactive PDF documents."
HOMEPAGE="https://code-industry.net/free-pdf-editor/"
SRC_URI="http://get.code-industry.net/public/master-pdf-editor-${PV}_qt5.amd64.tar.gz"

LICENSE="${PN}-${MV}"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="bindist mirror strip"

RDEPEND="
	app-arch/bzip2
	app-arch/lz4
	app-arch/xz-utils
	dev-libs/double-conversion
	dev-libs/glib:2
	dev-libs/icu
	dev-libs/libbsd
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libpcre
	dev-libs/libusb
	dev-libs/openssl
	>=dev-qt/qtcore-5.4.1
	>=dev-qt/qtgui-5.4.1
	>=dev-qt/qtnetwork-5.4.1
	>=dev-qt/qtprintsupport-5.4.1
	>=dev-qt/qtsvg-5.4.1
	>=dev-qt/qtwidgets-5.4.1
	media-gfx/graphite2
	media-gfx/sane-backends
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/tiff
	sys-apps/attr
	sys-apps/systemd
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libxcb
	virtual/opengl"

QA_PREBUILT="*"
S="${WORKDIR}/${PN}-${MV}"

src_install() {
	insinto /opt/${PN}
	doins -r fonts lang stamps templates
	doins license.txt masterpdfeditor4.png

	exeinto /opt/${PN}
	doexe masterpdfeditor4
	dosym ../../opt/${PN}/masterpdfeditor4 /usr/bin/masterpdfeditor

	make_desktop_entry "masterpdfeditor" "Master PDF Editor" "/opt/${PN}/masterpdfeditor4.png" "Utility;TextEditor"
}
