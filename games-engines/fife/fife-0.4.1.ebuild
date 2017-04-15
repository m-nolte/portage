# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1

DESCRIPTION="Multi-platform isometric game engine written in C++"
HOMEPAGE="http://www.fifengine.net"
SRC_URI="https://github.com/fifengine/fifengine/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cegui +fifechan librocket logging +opengl python"

REQUIRED_USE="cegui? ( opengl )
              python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="dev-libs/boost
		 dev-libs/tinyxml
		 media-libs/libogg
		 media-libs/libpng
         media-libs/libsdl2
		 media-libs/libvorbis
		 media-libs/openal
		 media-libs/sdl2-image
		 media-libs/sdl2-ttf
		 cegui? ( dev-games/cegui )
		 fifechan? ( games-engines/fifechan[opengl?,sdl] )
		 opengl? ( virtual/opengl
		           virtual/glu )
         python? ( dev-python/pyyaml[${PYTHON_USEDEP}]
                   ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
		python? ( >dev-lang/swig-3.0.8 )"

src_unpack() {
  default
  mv ${WORKDIR}/fifengine-${PV} ${WORKDIR}/fife-${PV}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  local mycmakeargs=(
	  -Dcegui="$(usex cegui ON OFF)"
	  -Dfifechan="$(usex fifechan ON OFF)"
	  -Dlibrocket="$(usex librocket ON OFF)"
	  -Dlogging="$(usex logging ON OFF)"
	  -Dopengl="$(usex opengl ON OFF)"
	  -Dbuild-library="ON"
	  -Dbuild-python="$(usex python ON OFF)"
    )
  cmake-utils_src_configure
}
