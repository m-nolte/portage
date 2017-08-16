# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit elisp-common eutils qmake-utils

SITEFILE="50${PN}-gentoo.el"

DESCRIPTION="The Programmers Solid 3D CAD Modeller"
HOMEPAGE="http://www.openscad.org/"
SRC_URI="http://files.openscad.org/openscad-2015.03-3.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs +qt4 qt5"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4[-egl]
		dev-qt/qtopengl:4[-egl]
		media-gfx/opencsg[qt4(+)]
		x11-libs/qscintilla:=[qt4(-)]
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtopengl:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
		media-gfx/opencsg[qt5(-)]
		x11-libs/qscintilla:=[qt5(-)]
	)
	dev-cpp/eigen:3
	dev-libs/glib:2
	dev-libs/gmp:0=
	dev-libs/mpfr:0=
	dev-libs/boost:=
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/glew:*
	media-libs/harfbuzz
	sci-mathematics/cgal
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

src_prepare() {
	#Use our CFLAGS (specifically don't force x86)
	sed -i "s/QMAKE_CXXFLAGS_RELEASE = .*//g" ${PN}.pro  || die
	sed -i "s/\/usr\/local/\/usr/g" ${PN}.pro || die

	epatch ${FILESDIR}/4fa5f0340a2b7b031a0b39f7de0ca795d52bb68b.patch

	eapply_user
}

src_configure() {
	local my_eqmake=eqmake$(usex qt5 5 4)
	${my_eqmake} "${PN}.pro"
}

src_compile() {
	default

	if use emacs ; then
		elisp-compile contrib/*.el
	fi
}

src_install() {
	emake install INSTALL_ROOT="${D}"

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
		elisp-install ${PN} contrib/*.el contrib/*.elc
	fi

	einstalldocs
}
