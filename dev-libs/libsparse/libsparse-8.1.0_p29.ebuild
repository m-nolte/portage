# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

MY_PV="${PV/_p/_r}"

DESCRIPTION="Library for sparse files"
HOMEPAGE="https://github.com/aosp-mirror/platform_system_core"
SRC_URI="https://github.com/aosp-mirror/platform_system_core/archive/android-${MY_PV}.tar.gz -> android-tools-${MY_PV}-core.tar.gz"

LICENSE="Apache-2.0 BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE="Release"
S=${WORKDIR}/platform_system_core-android-${MY_PV}/libsparse

src_prepare() {
  epatch ${FILESDIR}/0000-include-string.h.patch
  epatch ${FILESDIR}/0001-remove-dependency-on-android-base-from-libsparse.patch
  cp ${FILESDIR}/CMakeLists.txt ${S}/

  default
}
