# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="A Two-Dimensional Quality Mesh Generator and Delaunay Triangulator."
HOMEPAGE="https://www.cs.cmu.edu/~quake/triangle.html"
SRC_URI="http://www.netlib.org/voronoi/${PN}.zip -> ${P}.zip"

LICENSE="Triangle"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_compile() {
  $(tc-getCC) -DLINUX ${CFLAGS} ${LDFLAGS} -o triangle ${S}/triangle.c -lm
}

src_install() {
  dobin triangle
}
