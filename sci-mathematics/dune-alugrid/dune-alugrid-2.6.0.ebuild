# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION=3.1

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit cmake-utils python-single-r1

DESCRIPTION="DUNE, the Distributed and Unified Numerics Environment is a modular toolbox for solving partial differential equations with grid-based methods."
HOMEPAGE="https://dune-project.org"
SRC_URI="https://gitlab.dune-project.org/extensions/${PN}/repository/archive.tar.gz?ref=${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alberta arpack doc gmp istl metis mpi parmetis python suitesparse superlu ug vc zlib"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="=sci-mathematics/dune-grid-2.6*[alberta=,gmp=,metis=,mpi=,parmetis=,ug=,vc=]
		doc? ( app-doc/doxygen
			   dev-python/sphinx
               media-gfx/inkscape
			   virtual/imagemagick-tools
               virtual/latex-base )
		python? ( =sci-mathematics/dune-python-2.6*[alberta=,arpack=,gmp=,istl=,metis=,mpi=,parmetis=,suitesparse=,superlu=,ug=,vc=]
				  ${PYTHON_DEPS} )
		!python? ( !sci-mathematics/dune-python )
		zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_unpack() {
  unpack ${A}
  mv ${WORKDIR}/${PN}-* ${WORKDIR}/${P}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"

  # CMake flags that need to go into DUNE_CMAKE_FLAGS
  local mycmakeargs=(
	  $(cmake-utils_use_find_package zlib ZLIB)
      -DCMAKE_DISABLE_FIND_PACKAGE_DLMalloc=ON
      -DCMAKE_DISABLE_FIND_PACKAGE_SIONlib=ON
      -DCMAKE_DISABLE_FIND_PACKAGE_ZOLTAN=ON
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

  # CMake flags needed for dune-grid
  mycmakeargs+=(
      -Ddune-geometry_DIR=/usr/lib/cmake/dune-grid
      $(cmake-utils_use_find_package alberta Alberta)
      $(cmake-utils_use_find_package metis METIS)
      $(cmake-utils_use_find_package parmetis ParMETIS)
      -DCMAKE_DISABLE_FIND_PACKAGE_AmiraMesh=ON
      -DCMAKE_DISABLE_FIND_PACKAGE_Psurface=ON
    )

  if use istl ; then
    mycmakeargs+=(
        -Ddune-istl_DIR=/usr/lib/cmake/dune-istl
        $(cmake-utils_use_find_package arpack ARPACKPP)
        $(cmake-utils_use_find_package metis METIS)
        $(cmake-utils_use_find_package parmetis ParMETIS)
        $(cmake-utils_use_find_package superlu SuperLU)
        $(cmake-utils_use_find_package suitesparse SuiteSparse)
      )
  fi

  if use python ; then
	mycmakeargs+=(
		-Ddune-python_DIR=/usr/lib/cmake/dune-python
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
