# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Parallel AMR on Forests of Octrees"
HOMEPAGE="http://www.p4est.org"
SRC_URI="https://github.com/cburstedde/p4est/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpi romio static-libs threads"
REQUIRED_USE="romio? ( mpi )"

RDEPEND="
	dev-lang/lua
	=sci-libs/libsc-${PV}[mpi=,romio=,threads=]
	virtual/blas
	virtual/lapack
	mpi? ( virtual/mpi[romio=] )"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i -e 's/@P4EST_SC_AMFLAGS@//g' ${S}/Makefile.am

	# inject version number into build system
	echo "${PV}" > ${S}/.tarball-version

	default

	einfo "Regenerating autotools files..."
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable mpi) \
		$(use_enable romio mpiio) \
		$(use_enable static-libs static) \
		$(use_enable threads pthread) \
		--with-blas="$($(tc-getPKG_CONFIG) --libs blas)" \
		--with-lapack="$($(tc-getPKG_CONFIG) --libs lapack)" \
		--with-sc="${EPREFIX}/usr"
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
