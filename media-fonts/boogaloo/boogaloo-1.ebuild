# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Boogaloo was started in 2010 as a complement to the Salsa typeface, while thinking about type used in Latin American music genres and the culture's own identity. The structure of Boogaloo is that of classic American lettering, found so often in old LP albums cover art from the 1960s, when Latin music became very popular and preceding the birth of the musical phenomenon of Salsa."
HOMEPAGE="https://fonts.google.com/"
SRC_URI="https://fonts.google.com/download?family=Boogaloo -> ${PN}.zip"

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
