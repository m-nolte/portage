# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Open-source reimplementation of RollerCoaster Tycoon 2"
HOMEPAGE="https://openrct2.org"
SRC_URI="https://github.com/OpenRCT2/OpenRCT2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+http +lightfx +multiplayer +opengl +ttf"

RDEPEND="
	dev-libs/jansson
	dev-libs/libzip
	media-libs/libpng
	media-libs/libsdl2
	media-libs/speexdsp
	sys-libs/zlib
	http? ( net-misc/curl )
	multiplayer? ( dev-libs/openssl )
	opengl? ( virtual/opengl )
	ttf? ( media-libs/fontconfig 
	       media-libs/sdl2-ttf )"
DEPEND="${RDEPEND}"

src_unpack() {
  default
  mv ${WORKDIR}/OpenRCT2-${PV} ${WORKDIR}/openrct2-${PV}
}

src_prepare() {
  epatch ${FILESDIR}/remove-werror.patch
  epatch ${FILESDIR}/add-have-stdint-h.patch
  default
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  local mycmakeargs=(
      -DDISABLE_HTTP_TWITCH="$(usex http OFF ON)"
	  -DENABLE_LIGHTFX="$(usex lightfx ON OFF)"
	  -DDISABLE_NETWORK="$(usex multiplayer OFF ON)"
	  -DDISABLE_OPENGL="$(usex opengl OFF ON)"
	  -DDISABLE_TTF="$(usex ttf OFF ON)"
    )
  cmake-utils_src_configure
}
