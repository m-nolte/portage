# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="This font is based on the handwriting of a Korean high school student."
HOMEPAGE="https://fonts.google.com/"
SRC_URI="https://fonts.google.com/download?family=Gloria%20Hallelujah -> ${PN}.zip"

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
