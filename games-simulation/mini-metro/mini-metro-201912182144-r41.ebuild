# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils unpacker

DESCRIPTION="Mini Metro"
HOMEPAGE="https://dinopoloclub.com/games/mini-metro/"
SRC_URI="mini_metro_201912182144_release_41_34753.sh"

LICENSE="GOG-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist fetch"

DEPEND="
		app-arch/unzip
	"
RDEPEND="
		sys-devel/gcc
		sys-libs/glibc
	"

QA_PREBUILT="/opt/${PN}/*"

S="${WORKDIR}/data/noarch"

pkg_nofetch() {
	einfo "Please buy and download \"${SRC_URI}\" from"
	einfo "https://www.gog.com/game/mini_metro"
	einfo "and copy it to \"${DISTDIR}\""
}

src_unpack() {
	unpack_zip "${DISTDIR}/${SRC_URI}"
}

src_install() {
	local dir="/opt/${PN}"
	local arch=x86
	use amd64 && arch=x86_64

	insinto "${dir}"
	doins "game/Mini Metro.${arch}"

	insinto "${dir}/Mini Metro_Data"
	doins "game/Mini Metro_Data/boot.config"
	doins "game/Mini Metro_Data/globalgamemanagers"
	doins "game/Mini Metro_Data/globalgamemanagers.assets"
	doins "game/Mini Metro_Data/level0"
	doins "game/Mini Metro_Data/level1"
	doins "game/Mini Metro_Data/resources.assets"
	doins "game/Mini Metro_Data/resources.assets.resS"
	doins "game/Mini Metro_Data/sharedassets0.assets"
	doins "game/Mini Metro_Data/sharedassets1.assets"
	doins -r "game/Mini Metro_Data/Managed"
	doins -r "game/Mini Metro_Data/Resources"
	doins -r "game/Mini Metro_Data/StreamingAssets"

	insinto "${dir}/Mini Metro_Data/Mono"
	doins -r "game/Mini Metro_Data/Mono/${arch}"
	doins -r "game/Mini Metro_Data/Mono/etc"

	insinto "${dir}/Mini Metro_Data/Plugins"
	doins -r "game/Mini Metro_Data/Plugins/${arch}"

	fperms +x "${dir}/Mini Metro.${arch}"

	newicon "support/icon.png" "${PN}.png"
	make_wrapper "${PN}" "./Mini\ Metro.${arch}" "${dir}"
	make_desktop_entry "${PN}" "Mini Metro" "${PN}" "Game;Simulation"
}
