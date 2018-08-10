# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="A parser for GMSH's .msh format"
HOMEPAGE="http://github.com/inducer/gmsh_interop"
SRC_URI="https://files.pythonhosted.org/packages/ed/f6/e442f6346b04c565262cf7b12677a4b1a41cc1ed1f272aef912a32ce25cc/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
	dev-python/pytools[${PYTHON_USEDEP}]
	>=dev-python/six-1.8[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
