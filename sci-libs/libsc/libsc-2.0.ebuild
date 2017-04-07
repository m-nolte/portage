# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools toolchain-funcs eutils

DESCRIPTION="Support library for parallel scientific applications"
HOMEPAGE="http://www.p4est.org"
SRC_URI="https://github.com/cburstedde/libsc/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpi romio static-libs threads"
REQUIRED_USE="romio? ( mpi )"

RDEPEND="
	dev-lang/lua
	virtual/blas
	virtual/lapack
	mpi? ( virtual/mpi[romio=] )"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# remove ax_*.m4
	rm ${S}/config/ax_*.m4

	# inject version number into build system
	echo "${PV}" > ${S}/.tarball-version

	epatch ${FILESDIR}/install-m4s.patch
	epatch ${FILESDIR}/system-etc.patch
	epatch ${FILESDIR}/remove-la.patch

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
		--with-lapack="$($(tc-getPKG_CONFIG) --libs lapack)"
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
