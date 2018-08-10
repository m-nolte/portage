# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#EGIT_REPO_URI="https://github.com/inducer/meshpy.git"
#EGIT_COMMIT="v${PV}"

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1 #git-r3

DESCRIPTION="Quality triangular and tetrahedral mesh generation for Python"
HOMEPAGE="http://mathema.tician.de/software/meshpy"
SRC_URI="https://github.com/inducer/meshpy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT Triangle AGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-libs/boost[python,${PYTHON_USEDEP}]
	dev-python/gmsh_interop[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
	>=dev-python/pytools-2011.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.8[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/pytest-2[${PYTHON_USEDEP}] )"

python_prepare () {
	echo "USE_SHIPPED_BOOST = False" > "${BUILD_DIR}/../siteconf.py"
	echo "BOOST_INC_DIR = ['/usr/include']" >> "${BUILD_DIR}/../siteconf.py"
	echo "BOOST_LIB_DIR = ['/usr/lib']" >> "${BUILD_DIR}/../siteconf.py"
	echo "BOOST_PYTHON_LIBNAME = ['boost_python-${EPYTHON#python}-mt']" >> "${BUILD_DIR}/../siteconf.py"
}

python_test() {
	py.test || die
}
