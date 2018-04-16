# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION=3.1

inherit cmake-utils

DESCRIPTION="DUNE, the Distributed and Unified Numerics Environment is a modular toolbox for solving partial differential equations with grid-based methods."
HOMEPAGE="https://dune-project.org"
SRC_URI="https://gitlab.dune-project.org/core/${PN}/repository/archive.tar.gz?ref=v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arpack doc gmp metis mpi parmetis suitesparse superlu vc"

DEPEND="=sci-mathematics/dune-common-2.6*[gmp=,mpi=,vc=]
		arpack? ( sci-libs/arpack[mpi=] )
		doc? ( app-doc/doxygen
			   dev-python/sphinx
               media-gfx/inkscape
			   virtual/imagemagick-tools
               virtual/latex-base )
		metis? ( sci-libs/metis )
		parmetis? ( sci-libs/parmetis )
		superlu? ( sci-libs/superlu )
		suitesparse? ( sci-libs/suitesparse )"
RDEPEND="${DEPEND}"

src_unpack() {
  unpack ${A}
  mv ${WORKDIR}/${PN}-* ${WORKDIR}/${P}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"

  # CMake flags that need to go into DUNE_CMAKE_FLAGS
  local mycmakeargs=(
      $(cmake-utils_use_find_package arpack ARPACKPP)
      $(cmake-utils_use_find_package metis METIS)
      $(cmake-utils_use_find_package parmetis ParMETIS)
      $(cmake-utils_use_find_package superlu SuperLU)
      $(cmake-utils_use_find_package suitesparse SuiteSparse)
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
