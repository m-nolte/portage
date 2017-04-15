# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Racing game with rally style of driving, mostly on gravel"
HOMEPAGE="https://stuntrally.tuxfamily.org"
SRC_URI="https://github.com/stuntrally/stuntrally/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="editor +game server static"

RESTRICT_USE="editor? ( game )"

DEPEND="
		dev-libs/boost
		net-libs/enet:1.3
		virtual/libstdc++
		game? (
				dev-games/mygui[ogre,plugins]
				dev-games/ogre[boost,ois,freeimage,opengl,zip,-double-precision]
				media-libs/libogg
				media-libs/libsdl2[haptic]
				media-libs/libvorbis
				media-libs/openal
				sci-physics/bullet[bullet3,extras]
			)
	"
RDEPEND="
		${DEPEND}
		~games-sports/stuntrally-tracks-${PV}
	"

src_configure() {
	CMAKE_BUILD_TYPE="Release"
	local mycmakeargs=(
			-DBUILD_MASTER_SERVER=$(usex server ON OFF)
			$(cmake-utils_use_build game)
			$(cmake-utils_use_build server)
			-DBUILD_SHARED_LIBS=$(usex static OFF ON)
			-DSHARE_INSTALL="share/stuntrally"
		)
	cmake-utils_src_configure
}
