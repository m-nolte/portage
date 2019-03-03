# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

DESCRIPTION="Machinarium"
HOMEPAGE="https://amanita-design.net/games/machinarium.html"
SRC_URI="gog_machinarium_${PV}.sh"

LICENSE="GOG-EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

DEPEND="app-arch/unzip"
RDEPEND="
	app-arch/bzip2[abi_x86_32]
	dev-libs/atk[abi_x86_32]
	dev-libs/expat[abi_x86_32]
	dev-libs/fribidi[abi_x86_32]
	dev-libs/glib:2[abi_x86_32]
	dev-libs/libbsd[abi_x86_32]
	x11-libs/libdrm[abi_x86_32]
	dev-libs/libffi[abi_x86_32]
	dev-libs/libpcre[abi_x86_32]
	dev-libs/nspr[abi_x86_32]
	dev-libs/nss[abi_x86_32]
	dev-libs/wayland[abi_x86_32]
	media-gfx/graphite2[abi_x86_32]
	media-libs/fontconfig[abi_x86_32]
	media-libs/freetype[abi_x86_32]
	media-libs/harfbuzz[abi_x86_32]
	media-libs/libpng[abi_x86_32]
	media-libs/mesa[abi_x86_32]
	sys-devel/gcc[cxx]
	sys-apps/util-linux[abi_x86_32]
	sys-libs/glibc[multiarch]
	sys-libs/zlib[abi_x86_32]
	x11-libs/cairo[abi_x86_32]
	x11-libs/gdk-pixbuf[abi_x86_32]
	x11-libs/gtk+:2[abi_x86_32]
	x11-libs/libICE[abi_x86_32]
	x11-libs/libSM[abi_x86_32]
	x11-libs/libX11[abi_x86_32]
	x11-libs/libXau[abi_x86_32]
	x11-libs/libxcb[abi_x86_32]
	x11-libs/libXcomposite[abi_x86_32]
	x11-libs/libXcursor[abi_x86_32]
	x11-libs/libXdamage[abi_x86_32]
	x11-libs/libXdmcp[abi_x86_32]
	x11-libs/libXext[abi_x86_32]
	x11-libs/libXfixes[abi_x86_32]
	x11-libs/libXi[abi_x86_32]
	x11-libs/libXrandr[abi_x86_32]
	x11-libs/libXrender[abi_x86_32]
	x11-libs/libxshmfence[abi_x86_32]
	x11-libs/libXt[abi_x86_32]
	x11-libs/libXxf86vm[abi_x86_32]
	x11-libs/pango[abi_x86_32]
	x11-libs/pixman[abi_x86_32]
	"

QA_PREBUILT="/opt/${PN}/Machinarium"

S="${WORKDIR}/data/noarch"

pkg_nofetch() {
	einfo "Please buy and download \"${SRC_URI}\" from"
	einfo "https://www.gog.com/game/machinarium_collectors_edition"
	einfo "and copy it to \"${DISTDIR}\""
}

src_unpack() {
	unpack_zip "${DISTDIR}/${SRC_URI}"
}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r "game/."
	fperms +x "${dir}/Machinarium"

	newicon "support/icon.png" "${PN}.png"
	make_wrapper ${PN} "./Machinarium" "${dir}"
	make_desktop_entry "${PN}" "Machinarium" "${PN}" "Game;AdventureGame"
}
