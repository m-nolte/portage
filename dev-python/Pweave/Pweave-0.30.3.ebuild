# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_4 python3_5 python3_6 )
inherit distutils-r1

DESCRIPTION="Scientific reports with embedded python computations with reST, LaTeX or markdown"
HOMEPAGE="http://mpastell.com/pweave/"
SRC_URI="https://github.com/mpastell/Pweave/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
  dev-python/ipykernel[${PYTHON_USEDEP}]
  dev-python/ipython[${PYTHON_USEDEP}]
  dev-python/jupyter_client[${PYTHON_USEDEP}]
  dev-python/markdown[${PYTHON_USEDEP}]
  dev-python/nbconvert[${PYTHON_USEDEP}]
  dev-python/nbformat[${PYTHON_USEDEP}]
  dev-python/pygments[${PYTHON_USEDEP}]
		  
"
RDEPEND="${DEPEND}"
