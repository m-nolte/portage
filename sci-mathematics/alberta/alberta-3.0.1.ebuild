# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="ALBERTA - An adaptive hierarchical finite element toolbox"
HOMEPAGE="http://www.alberta-fem.de/"
SRC_URI="http://www.mathematik.uni-stuttgart.de/fak8/ians/lehrstuhl/nmh/downloads/alberta/alberta-3.0.1.tar.gz"

LICENSE="GLP-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
  econf \
	  --enable-plain-malloc \
	  --disable-dependency-tracking \
	  --disable-graphics
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
