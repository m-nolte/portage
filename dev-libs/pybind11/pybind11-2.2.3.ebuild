# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Lightweight library that exposes C++ types in Python and vice versa"
HOMEPAGE="https://github.com/wjakob/pybind11"
SRC_URI="https://github.com/pybind/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
  epatch ${FILESDIR}/cmake-files-install-path.patch
  cmake-utils_src_prepare
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  local mycmakeargs=(
  	  -DPYBIND11_INSTALL=ON
	  -DPYBIND11_TEST=OFF
	)
  cmake-utils_src_configure
}

src_compile() {
  cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
