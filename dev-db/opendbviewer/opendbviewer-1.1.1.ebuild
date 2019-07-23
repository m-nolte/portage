# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="OpenDBViewer is a simple database explorer for Windows, Linux and Mac OS X."
HOMEPAGE="https://github.com/Jet1oeil/opendbviewer"
SRC_URI="https://github.com/Jet1oeil/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtsql:5
		dev-qt/qttest:5
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  cmake-utils_src_configure
}

src_compile() {
  cmake-utils_src_compile
}

src_install() {
  cmake-utils_src_install
}
