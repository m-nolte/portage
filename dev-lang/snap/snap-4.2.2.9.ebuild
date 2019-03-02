# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="Snap! Build Your Own Blocks is a visual, blocks based programming language inspired by Scratch."
HOMEPAGE="http://snap.berkeley.edu"
SRC_URI="https://github.com/jmoenig/Snap/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="www-client/firefox"
DEPEND="
	media-gfx/imagemagick
	${RDEPEND}
"

S=${WORKDIR}/Snap-${PV}

src_install() {
	declare SNAP_HOME=/opt/snap

	insinto ${SNAP_HOME}
	doins ${S}/snap.html
	doins -r ${S}/Backgrounds
	doins -r ${S}/Costumes
	doins -r ${S}/Examples
	doins -r ${S}/Sounds
	doins -r ${S}/help
	doins -r ${S}/libraries
	doins -r ${S}/locale
	doins -r ${S}/src

	convert "${S}/src/favicon.ico[0]" ${S}/snap-32.png
	convert "${S}/src/favicon.ico[1]" ${S}/snap-24.png
	convert "${S}/src/favicon.ico[2]" ${S}/snap-16.png

	for size in 16 24 32 ; do
		newicon -s ${size} ${S}/snap-${size}.png Snap-BuildYourOwnBlocks.png
	done

	make_desktop_entry "firefox ${SNAP_HOME}/snap.html" "Snap - Build Your Own Blocks" "Snap-BuildYourOwnBlocks" "Development"
}
