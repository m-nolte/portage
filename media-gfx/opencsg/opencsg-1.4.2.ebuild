# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

MY_P="OpenCSG-${PV}"
DESCRIPTION="The Constructive Solid Geometry rendering library"
HOMEPAGE="http://www.opencsg.org"
SRC_URI="http://www.opencsg.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 qt5"

REQUIRED_USE="^^ ( qt4 qt5 )"

COMMON_DEPEND="
	media-libs/glew:0
	qt4? ( dev-qt/qtcore:4 )
	qt5? ( dev-qt/qtcore:5 )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}/src"

src_prepare() {
	default

	# removes duplicated headers
	rm -r ../glew || die "failed to remove bundled glew"

	sed -i -e 's:^INSTALLDIR.*:INSTALLDIR = /usr:' src.pro \
		|| die 'failed to fix INSTALLDIR in src.pro'

	sed -i -e "s:^target.path.*:target.path = \$\$INSTALLDIR/$(get_libdir):" \
		src.pro \
		|| die 'failed to fix target.path in src.pro'
}

src_configure() {
	local my_eqmake=eqmake$(usex qt5 5 4)
	${my_eqmake} src.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
