# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="DUNE, the Distributed and Unified Numerics Environment is a modular toolbox for solving partial differential equations with grid-based methods."
HOMEPAGE="https://dune-project.org"
SRC_URI="https://gitlab.dune-project.org/core/${PN}/repository/archive.tar.gz?ref=v2.6.0rc1 -> ${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arpack doc gmp metis mpi parmetis superlu suitesparse vc"

DEPEND=">=dev-util/cmake-3.1
		dev-util/pkgconfig
		=sci-mathematics/dune-common-2.6*[gmp=,mpi=,vc=]
		arpack? ( sci-libs/arpack[mpi=] )
		doc? ( app-doc/doxygen
			   dev-python/sphinx
               media-gfx/inkscape
			   virtual/imagemagick-tools
               virtual/latex-base )
		gmp? ( dev-libs/gmp )
		metis? ( sci-libs/metis )
		mpi? ( virtual/mpi )
		parmetis? ( sci-libs/parmetis )
		superlu? ( sci-libs/superlu )
		suitesparse? ( sci-libs/suitesparse )
        vc? ( dev-libs/vc )"
RDEPEND="${DEPEND}"

src_unpack() {
  unpack ${A}
  mv ${WORKDIR}/${PN}-* ${WORKDIR}/${P}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  local mycmakeargs=(
	  -Ddune-common_DIR=/usr/lib/cmake/dune-common
	  -DBUILD_SHARED_LIBS=TRUE
	  -DCMAKE_DISABLE_FIND_PACKAGE_ARPACKPP="$(usex arpack FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen="$(usex doc FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_LATEX="$(usex doc FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_Sphinx="$(usex doc FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_GMP="$(usex gmp FALSE TRUE)"
      -DCMAKE_DISABLE_FIND_PACKAGE_METIS="$(usex metis FALSE TRUE)"
      -DCMAKE_DISABLE_FIND_PACKAGE_MPI="$(usex mpi FALSE TRUE)"
      -DCMAKE_DISABLE_FIND_PACKAGE_ParMETIS="$(usex parmetis FALSE TRUE)"
      -DCMAKE_DISABLE_FIND_PACKAGE_SuperLU="$(usex superlu FALSE TRUE)"
      -DCMAKE_DISABLE_FIND_PACKAGE_SuiteSparse="$(usex suitesparse FALSE TRUE)"
	  -DCMAKE_DISABLE_FIND_PACKAGE_Vc="$(usex vc FALSE TRUE)"
    )
  cmake-utils_src_configure
}

src_compile() {
  cmake-utils_src_compile
}

src_install() {
    cmake-utils_src_install
}
