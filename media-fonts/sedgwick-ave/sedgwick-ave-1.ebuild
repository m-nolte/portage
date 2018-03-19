# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Designed for the Google Doodle celebrating the 44th anniversary of the birth of Hip Hop, the Sedgwick Ave project expresses handwritten graffiti letterforms with two designs."
HOMEPAGE="https://fonts.google.com/"
SRC_URI="https://fonts.google.com/download?family=Sedgwick%20Ave -> ${PN}.zip
		 https://fonts.google.com/download?family=Sedgwick%20Ave%20Display -> ${PN}-display.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
  mkdir -p ${S}
  cd ${S}
  unpack ${A}
}
