# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Tangerine is a calligraphic typeface inspired by many italic chancery hands from the 16th and 17th centuries."
HOMEPAGE="https://fonts.google.com/"
SRC_URI="https://fonts.google.com/download?family=Tangerine -> ${PN}.zip"

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
