# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION=3.3

inherit cmake-utils

DESCRIPTION="Simple drawing program for kids."
HOMEPAGE="https://github.com/m-nolte/kidz-draw"
SRC_URI="https://github.com/m-nolte/kidz-draw/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/imagemagick[png,svg]
		media-libs/libpng
		media-libs/libsdl2
		net-libs/libmicrohttpd"
RDEPEND="${DEPEND}"

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
