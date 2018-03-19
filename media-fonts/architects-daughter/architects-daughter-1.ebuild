# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Inspired by the writing of the daughter of an architect (surprise, surprise!), this font incorporates the graphic, squared look of architectural writing, combined with the natural feel of daily handwriting."
HOMEPAGE="https://fonts.google.com/"
SRC_URI="https://fonts.google.com/download?family=Architects%20Daughter -> ${PN}.zip"

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
