# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Lightweight cross platform GUI library written in C++ specifically designed for games"
HOMEPAGE="http://www.fifengine.net"
SRC_URI="https://github.com/fifengine/fifechan/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="allegro irrlicht +opengl +sdl"

DEPEND="allegro? ( media-libs/allegro )
        irrlicht? ( dev-games/irrlicht )
		opengl? ( virtual/opengl )
		sdl? ( media-libs/libsdl2
		       media-libs/sdl2-image )"
RDEPEND="${DEPEND}"

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  local mycmakeargs=(
	  -DENABLE_ALLEGRO="$(usex allegro ON OFF)"
	  -DENABLE_IRRLICHT="$(usex irrlicht ON OFF)"
	  -DENABLE_OPENGL="$(usex opengl ON OFF)"
	  -DENABLE_SDL="$(usex sdl ON OFF)"
    )
  cmake-utils_src_configure
}
