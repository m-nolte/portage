# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

COMMIT=cb002e4eb8d167c2c60fc3bdaae4e1844e0f9353

DESCRIPTION="Collective communications library with various primitives for multi-machine training."
HOMEPAGE="https://github.com/facebookincubator/gloo"
SRC_URI="https://github.com/facebookincubator/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${COMMIT}

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
