# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="2D real time strategy simulation with an emphasis on economy and city building"
HOMEPAGE="http://www.unknown-horizons.org"
SRC_URI="https://github.com/unknown-horizons/unknown-horizons/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
        games-engines/fife[python,${PYTHON_USEDEP}]
		${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
