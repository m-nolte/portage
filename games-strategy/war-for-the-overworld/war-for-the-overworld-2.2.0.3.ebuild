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
RDEPEND="sys-devel/gcc[cxx]
		 sys-libs/glibc
		 virtual/opengl
	     x11-libs/libX11
		 x11-libs/libXcursor
		 x11-libs/libXrandr"

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

	insinto "${dir}"
	doins -r "game/."

	newicon "support/icon.png" "${PN}.png"
	make_wrapper ${PN} "./WFTOGame.x86_64" "${dir}"
	make_desktop_entry "${PN}" "War for the Overworld" "${PN}" "Game;StrategyGame"
}
