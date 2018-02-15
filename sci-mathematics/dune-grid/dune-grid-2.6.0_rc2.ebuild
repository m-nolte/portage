# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION=3.1

inherit cmake-utils

DESCRIPTION="DUNE, the Distributed and Unified Numerics Environment is a modular toolbox for solving partial differential equations with grid-based methods."
HOMEPAGE="https://dune-project.org"
SRC_URI="https://gitlab.dune-project.org/core/${PN}/repository/archive.tar.gz?ref=v2.6.0rc2 -> ${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alberta doc gmp metis mpi parmetis ug vc"

DEPEND="=sci-mathematics/dune-common-2.6*[gmp=,mpi=,vc=]
		=sci-mathematics/dune-geometry-2.6*[gmp=,mpi=,vc=]
		alberta? ( sci-mathematics/alberta )
		doc? ( app-doc/doxygen
			   dev-python/sphinx
               media-gfx/inkscape
			   virtual/imagemagick-tools
               virtual/latex-base )
		metis? ( sci-libs/metis )
		parmetis? ( sci-libs/parmetis )
		ug? ( =sci-mathematics/dune-uggrid-2.6*[gmp=,mpi=,vc=] )
		!ug? ( !sci-mathematics/dune-uggrid )"
RDEPEND="${DEPEND}"

src_unpack() {
  unpack ${A}
  mv ${WORKDIR}/${PN}-* ${WORKDIR}/${P}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"

  # CMake flags that need to go into DUNE_CMAKE_FLAGS
  local mycmakeargs=(
	  $(cmake-utils_use_find_package alberta Alberta)
	  $(cmake-utils_use_find_package metis METIS)
	  $(cmake-utils_use_find_package parmetis ParMETIS)
      -DCMAKE_DISABLE_FIND_PACKAGE_AmiraMesh=ON
      -DCMAKE_DISABLE_FIND_PACKAGE_Psurface=ON
	)

  # generate the env.d file
  ENVFILE=${WORKDIR}/99${PN}
  printf 'DUNE_CMAKE_FLAGS="' > ${ENVFILE}
  printf ' %s' "${mycmakeargs[@]}" >> ${ENVFILE}
  printf '"\n' >> ${ENVFILE}

  # CMake flags needed for dune-common
  mycmakeargs+=(
      -Ddune-common_DIR=/usr/lib/cmake/dune-common
      -DBUILD_SHARED_LIBS=ON
      $(cmake-utils_use_find_package gmp GMP)
      $(cmake-utils_use_find_package mpi MPI)
      $(cmake-utils_use_find_package vc Vc)
    )

  # CMake flags needed for dune-geometry
  mycmakeargs+=(
	  -Ddune-geometry_DIR=/usr/lib/cmake/dune-geometry
	)

  # CMake flags for dune-uggrid
  if use ug ; then
	mycmakeargs+=(
		-Ddune-uggrid_DIR=/usr/lib/cmake/dune-uggrid
	  )
  fi

  # CMake flags for documentation
  mycmakeargs+=(
      $(cmake-utils_use_find_package doc Doxygen)
      $(cmake-utils_use_find_package doc LATEX)
      $(cmake-utils_use_find_package doc Sphinx)
    )

  cmake-utils_src_configure
}

src_compile() {
  cmake-utils_src_compile
}

src_install() {
  cmake-utils_src_install
  doenvd ${WORKDIR}/99${PN}
}
