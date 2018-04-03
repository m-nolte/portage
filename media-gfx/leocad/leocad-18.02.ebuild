# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils qmake-utils xdg-utils

DESCRIPTION="LeoCAD is a CAD program for creating virtual LEGO models."
HOMEPAGE="https://www.leocad.org"
SRC_URI="
  https://github.com/leozide/leocad/archive/v${PV}.tar.gz -> ${P}.tar.gz
  https://github.com/leozide/leocad/releases/download/v${PV}/Library-Linux-11331.zip -> ${P}-library.zip
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
  dev-qt/qtcore:5
  dev-qt/qtopengl:5
  dev-qt/qtconcurrent:5
"
RDEPEND="
  ${DEPEND}
  x11-themes/hicolor-icon-theme
"

PATCHES=(
  ${FILESDIR}/01-desktop-file.patch
)

src_configure() {
  eqmake5 ${PN}.pro DISABLE_UPDATE_CHECK=1
}

src_install() {
  emake INSTALL_ROOT="${D}" install
  insinto /usr/share/${PN}
  doins "${WORKDIR}/library.bin"
}

pkg_postinst() {
  xdg_desktop_database_update
  xdg_mimeinfo_database_update
}

pkg_postrm() {
  xdg_desktop_database_update
  xdg_mimeinfo_database_update
}
