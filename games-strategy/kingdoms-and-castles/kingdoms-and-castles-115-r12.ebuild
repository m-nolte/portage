# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils unpacker

DESCRIPTION="Kingdoms and Castles"
HOMEPAGE="https://kingdomsandcastles.com/"
SRC_URI="kingdoms_and_castles_115r12_30594.sh"

LICENSE="GOG-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist fetch"

DEPEND="
		app-arch/unzip
	"
RDEPEND="
		app-arch/bzip2
		dev-libs/atk
		dev-libs/expat
		dev-libs/fribidi
		dev-libs/glib
		dev-libs/libbsd
		dev-libs/libffi
		dev-libs/libpcre
		media-gfx/graphite2
		media-libs/fontconfig
		media-libs/freetype
		media-libs/harfbuzz
		media-libs/libpng
		sys-apps/util-linux
		sys-devel/gcc
		sys-libs/glibc
		sys-libs/zlib
		virtual/opengl
		x11-libs/cairo
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:2
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
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/pango
		x11-libs/pixman
	"

QA_PREBUILT="/opt/${PN}/*"

S="${WORKDIR}/data/noarch"

pkg_nofetch() {
	einfo "Please buy and download \"${SRC_URI}\" from"
	einfo "https://www.gog.com/game/kingdoms_castles"
	einfo "and copy it to \"${DISTDIR}\""
}

src_unpack() {
	unpack_zip "${DIRTDIR}/${SRC_URI}"
}

src_install() {
	local dir="/opt/${PN}"
	local arch=x86
	use amd64 && arch=x86_64

	insinto "${dir}"
	doins "game/KingdomsAndCastles.${arch}"

	insinto "${dir}/KingdomsAndCastles_Data"
	doins "game/KingdomsAndCastles_Data/boot.config"
	doins "game/KingdomsAndCastles_Data/globalgamemanagers"
	doins "game/KingdomsAndCastles_Data/globalgamemanagers.assets"
	doins "game/KingdomsAndCastles_Data/globalgamemanagers.assets.resS"
	doins "game/KingdomsAndCastles_Data/level0"
	doins "game/KingdomsAndCastles_Data/level1"
	doins "game/KingdomsAndCastles_Data/resources.assets"
	doins "game/KingdomsAndCastles_Data/resources.assets.resS"
	doins "game/KingdomsAndCastles_Data/resources.resource"
	doins "game/KingdomsAndCastles_Data/sharedassets1.assets"
	doins "game/KingdomsAndCastles_Data/sharedassets1.assets.resS"
	doins "game/KingdomsAndCastles_Data/sharedassets1.resource"
	doins -r "game/KingdomsAndCastles_Data/Managed"
	doins -r "game/KingdomsAndCastles_Data/Resources"

	insinto "${dir}/KingdomsAndCastles_Data/MonoBleedingEdge"
	doins -r "game/KingdomsAndCastles_Data/MonoBleedingEdge/${arch}"
	doins -r "game/KingdomsAndCastles_Data/MonoBleedingEdge/etc"

	insinto "${dir}/KingdomsAndCastles_Data/Plugins"
	doins -r "game/KingdomsAndCastles_Data/Plugins/${arch}"

	fperms +x "${dir}/KingdomsAndCastles.${arch}"

	newicon "support/icon.png" "${PN}.png"
	make_wrapper "${PN}" "./KingdomsAndCastles.x86_64" "${dir}"
	make_desktop_entry "${PN}" "Kingdoms and Castles" "${PN}" "Game;StrategyGame"
}
