# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Tracks for Stunt Rally"
HOMEPAGE="https://stuntrally.tuxfamily.org"
SRC_URI="https://github.com/stuntrally/tracks/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/tracks-${PV}"

src_configure() {
	local mycmakeargs=(
			-DSHARE_INSTALL="/usr/share/stuntrally"
		)
	cmake-utils_src_configure
}
