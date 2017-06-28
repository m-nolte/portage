# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

DESCRIPTION="War for the Overworld"
HOMEPAGE="https://wftogame.com/"
SRC_URI="gog_war_for_the_overworld_${PV}.sh"

LICENSE="GOG-EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

DEPEND="app-arch/unzip"
RDEPEND="dev-libs/glib:2
		 dev-libs/nspr
		 dev-libs/nss
		 gnome-base/gconf
		 media-libs/alsa-lib
		 media-libs/fontconfig
		 media-libs/freetype
		 sys-devel/gcc[cxx]
		 sys-libs/glibc
		 sys-libs/libcap
		 sys-libs/libudev-compat
		 virtual/opengl
		 x11-libs/cairo
		 x11-libs/gdk-pixbuf
		 x11-libs/gtk+:2
		 x11-libs/pango
	     x11-libs/libX11
		 x11-libs/libXcomposite
		 x11-libs/libXcursor
		 x11-libs/libXdamage
		 x11-libs/libXext
		 x11-libs/libXfixes
		 x11-libs/libXi
		 x11-libs/libXrandr
		 x11-libs/libXrender
		 x11-libs/libXtst"

QA_PREBUILT="/opt/${PN}/WFTOGame.x86_64"

S="${WORKDIR}/data/noarch"

pkg_nofetch() {
	einfo "Please buy and download \"${SRC_URI}\" from"
	einfo "https://www.gog.com/game/war_for_the_overworld"
	einfo "and copy it to \"${DISTDIR}\""
}

src_unpack() {
	unpack_zip "${DISTDIR}/${SRC_URI}"
}

src_install() {
	local dir="/opt/${PN}"

	mv game/WFTOGame_Data/CoherentUI_Host/linux/CoherentUI_Host.bin game/WFTOGame_Data/CoherentUI_Host/linux/CoherentUI_Host
	rm game/WFTOGame_Data/CoherentUI_Host/linux/*.meta
	rm game/WFTOGame_Data/GameData/Maps/*.meta

	insinto "${dir}"
	doins -r "game/."
	fperms +x "${dir}/WFTOGame.x86_64"
	fperms +x "${dir}/WFTOGame_Data/CoherentUI_Host/linux/CoherentUI_Host"

	newicon "support/icon.png" "${PN}.png"
	make_wrapper ${PN} "./WFTOGame.x86_64" "${dir}"
	make_desktop_entry "${PN}" "War for the Overworld" "${PN}" "Game;StrategyGame"
}
