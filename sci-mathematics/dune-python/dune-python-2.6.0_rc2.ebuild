# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit cmake-utils python-single-r1

DESCRIPTION="DUNE, the Distributed and Unified Numerics Environment is a modular toolbox for solving partial differential equations with grid-based methods."
HOMEPAGE="https://dune-project.org"
SRC_URI="https://gitlab.dune-project.org/staging/${PN}/repository/archive.tar.gz?ref=v2.6.0rc2 -> ${P}.tar.gz"

LICENSE="|| ( GPL-2-with-linking-exception LGPL-3+ )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alberta arpack doc gmp istl metis mpi parmetis superlu suitesparse ug vc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=">=dev-util/cmake-3.1
		dev-util/pkgconfig
		=sci-mathematics/dune-common-2.6*[gmp=,mpi=,vc=]
		=sci-mathematics/dune-geometry-2.6*[gmp=,mpi=,vc=]
		=sci-mathematics/dune-grid-2.6*[alberta=,gmp=,metis=,mpi=,parmetis=,ug=,vc=]
		alberta? ( sci-mathematics/alberta )
		doc? ( app-doc/doxygen
			   dev-python/sphinx
               media-gfx/inkscape
			   virtual/imagemagick-tools
               virtual/latex-base )
		gmp? ( dev-libs/gmp )
		istl? ( =sci-mathematics/dune-istl-2.6*[arpack=,gmp=,metis=,mpi=,parmetis=,superlu=,suitesparse=,vc=]
			    arpack? ( sci-libs/arpack[mpi=] )
				superlu? ( sci-libs/superlu )
				suitesparse? ( sci-libs/suitesparse ) )
		metis? ( sci-libs/metis )
		mpi? ( virtual/mpi )
		parmetis? ( sci-libs/parmetis )
		ug? ( =sci-mathematics/dune-uggrid-2.6*[gmp=,mpi=,vc=] )
        vc? ( dev-libs/vc )
		${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

src_unpack() {
  unpack ${A}
  mv ${WORKDIR}/${PN}-* ${WORKDIR}/${P}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  local mycmakeargs=(
	  -Ddune-common_DIR=/usr/lib/cmake/dune-common
	  -Ddune-geometry_DIR=/usr/lib/cmake/dune-geometry
	  -Ddune-grid_DIR=/usr/lib/cmake/dune-grid
	  -DBUILD_SHARED_LIBS=TRUE
	  -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen="$(usex doc FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_LATEX="$(usex doc FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_Sphinx="$(usex doc FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_Alberta="$(usex alberta FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_AmiraMesh="FALSE"
	  -DCMAKE_DISABLE_FIND_PACKAGE_GMP="$(usex gmp FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_METIS="$(usex metis FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_MPI="$(usex mpi FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_ParMETIS="$(usex parmetis FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_Psurface="FALSE"
	  -DCMAKE_DISABLE_FIND_PACKAGE_Vc="$(usex vc FALSE TRUE)"
	)
  if use ug ; then
	local mycmakeargs+=(
		-Ddune-uggrid_DIR=/usr/lib/cmake/dune-uggrid
	  )
  fi
  if use istl ; then
	local mycmakeargs+=(
		-Ddune-istl_DIR=/usr/lib/cmake/dune-istl
		-DCMAKE_DISABLE_FIND_PACKAGE_ARPACKPP="$(usex arpack FALSE TRUE)"
        -DCMAKE_DISABLE_FIND_PACKAGE_SuperLU="$(usex superlu FALSE TRUE)"
        -DCMAKE_DISABLE_FIND_PACKAGE_SuiteSparse="$(usex suitesparse FALSE TRUE)"
	  )
  fi
  cmake-utils_src_configure
}

src_compile() {
  cmake-utils_src_compile
}

src_install() {
  cmake-utils_src_install
  pushd ${BUILD_DIR}/python || die
  ${PYTHON} setup.py install --root ${D} --prefix ${EPREFIX}/usr || die "Installing Python package failed."
  popd || die
}
