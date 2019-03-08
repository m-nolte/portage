# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils unpacker

DESCRIPTION="Sphinx and the Cursed Mummy"
HOMEPAGE="https://www.gog.com/game/sphinx_and_the_cursed_mummy"
SRC_URI="sphinx_and_the_cursed_mummy_$(ver_rs 1- '_').sh"

LICENSE="GOG-EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="
	app-arch/lz4[abi_x86_32]
	dev-libs/expat[abi_x86_32]
	dev-libs/libbsd[abi_x86_32]
	dev-libs/libffi[abi_x86_32]
	dev-libs/libgcrypt[abi_x86_32]
	dev-libs/libgpg-error[abi_x86_32]
	dev-libs/wayland[abi_x86_32]
	media-libs/alsa-lib[abi_x86_32]
	media-libs/flac[abi_x86_32]
	net-libs/libasyncns[abi_x86_32]
	media-libs/libogg[abi_x86_32]
	media-libs/libsdl2[abi_x86_32]
	media-libs/libsndfile[abi_x86_32]
	media-libs/mesa[abi_x86_32]
	media-libs/openal[abi_x86_32]
	media-libs/libvorbis[abi_x86_32]
	media-sound/pulseaudio[abi_x86_32]
	sys-apps/dbus[abi_x86_32]
	sys-apps/systemd[abi_x86_32]
	sys-devel/gcc[cxx]
	sys-libs/glibc[multiarch]
	sys-libs/libcap[abi_x86_32]
	x11-libs/libdrm[abi_x86_32]
	x11-libs/libX11[abi_x86_32]
	x11-libs/libXau[abi_x86_32]
	x11-libs/libxcb[abi_x86_32]
	x11-libs/libXcursor[abi_x86_32]
	x11-libs/libXdamage[abi_x86_32]
	x11-libs/libXdmcp[abi_x86_32]
	x11-libs/libXext[abi_x86_32]
	x11-libs/libXfixes[abi_x86_32]
	x11-libs/libXi[abi_x86_32]
	x11-libs/libXinerama[abi_x86_32]
	x11-libs/libxkbcommon[abi_x86_32]
	x11-libs/libXrandr[abi_x86_32]
	x11-libs/libXrender[abi_x86_32]
	x11-libs/libxshmfence[abi_x86_32]
	x11-libs/libXxf86vm[abi_x86_32]
	virtual/opengl[abi_x86_32]
	"

QA_PREBUILT="/opt/${PN}/Sphinx.elf"

S="${WORKDIR}/data/noarch"

pkg_nofetch() {
	einfo "Please buy and download \"${SRC_URI}\" from"
	einfo "https://www.gog.com/game/sphinx_and_the_cursed_mummy"
	einfo "and copy it to \"${DISTDIR}\""
}

src_unpack() {
	unpack_zip "${DISTDIR}/${SRC_URI}"
}

src_prepare() {
	rm -r "game/_fallbackLinuxLibraries"
	default
}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r "game/."
	fperms +x "${dir}/Sphinx.elf"

	newicon "support/icon.png" "${PN}.png"
	make_wrapper ${PN} "./Sphinx.elf" "${dir}"
	make_desktop_entry "${PN}" "Sphinx and the Cursed Mummy" "${PN}" "Game;ActionGame"
}
