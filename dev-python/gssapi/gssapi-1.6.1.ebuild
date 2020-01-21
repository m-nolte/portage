# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="A Python interface to RFC 2743/2744 (plus common extensions)"
HOMEPAGE="https://github.com/pythongssapi/python-gssapi"
SRC_URI="https://github.com/pythongssapi/python-gssapi/archive/v${PV}.tar.gz -> python-gssapi-${PV}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
		dev-python/cython[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
	"
RDEPEND="
		dev-python/decorator[${PYTHON_USEDEP}]
		>=dev-python/six-1.4.9[${PYTHON_USEDEP}]
		python_targets_python2_7? ( dev-python/enum3_4[${PYTHON_USEDEP}] )
	"

S=${WORKDIR}/python-gssapi-${PV}
