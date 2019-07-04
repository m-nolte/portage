# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://vscode-update.azurewebsites.net/${PV}"
SRC_URI="${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz
	"
RESTRICT="mirror strip"

LICENSE="EULA MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libsecret"

DEPEND="
	app-accessibility/at-spi2-atk
	app-arch/bzip2
	app-arch/lz4
	dev-libs/atk
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/gmp
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libpcre
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nss
	dev-libs/wayland
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	>=media-libs/libpng-1.2.46
	net-dns/libidn2
	net-libs/gnutls
	>=net-print/cups-2.0.0
	sys-apps/systemd
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	virtual/opengl
"

RDEPEND="
	${DEPEND}
	libsecret? ( app-crypt/libsecret[crypt] )
"

QA_PRESTRIPPED="opt/${PN}/code"
QA_PREBUILT="opt/${PN}/code"

S="${WORKDIR}/VSCode-linux-x64"

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/bin/code" "/usr/bin/${PN}"
	make_desktop_entry "${PN}" "Visual Studio Code" "${PN}" "Development;IDE"
	newicon ${S}/resources/app/resources/linux/code.png ${PN}.png
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/libffmpeg.so"
	fperms +x "/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	insinto "/usr/share/licenses/${PN}"
	newins "resources/app/LICENSE.rtf" "LICENSE.rtf"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
