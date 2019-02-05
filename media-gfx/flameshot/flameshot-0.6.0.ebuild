# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://github.com/lupoDharkael/flameshot"
SRC_URI="https://github.com/lupoDharkael/flameshot/archive/v${PV}.tar.gz"

LICENSE="GPL-3 FreeArt Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-qt/qtcore-5.3:5
	>=dev-qt/qtdbus-5.3:5
	>=dev-qt/qtnetwork-5.3:5
	>=dev-qt/qtsvg-5.3:5
	>=dev-qt/qtwidgets-5.3:5
	>=dev-qt/linguist-tools-5.3:5
	"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5 CONFIG+=packaging ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
