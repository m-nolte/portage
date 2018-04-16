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
IUSE="doc gmp mpi vc"

DEPEND=" =sci-mathematics/dune-common-2.6*[gmp=,mpi=,vc=]
		doc? ( app-doc/doxygen
			   dev-python/sphinx
               media-gfx/inkscape
			   virtual/imagemagick-tools
               virtual/latex-base )"
RDEPEND="${DEPEND}"

src_unpack() {
  unpack ${A}
  mv ${WORKDIR}/${PN}-* ${WORKDIR}/${P}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"

  # We have no CMake flags of our own, so no env.d file is needed

  # CMake flags needed for dune-common
  local mycmakeargs=(
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
}
