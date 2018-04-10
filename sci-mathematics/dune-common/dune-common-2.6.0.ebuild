# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION=3.1

inherit cmake-utils

DESCRIPTION="DUNE, the Distributed and Unified Numerics Environment is a modular toolbox for solving partial differential equations with grid-based methods."
HOMEPAGE="https://dune-project.org"
SRC_URI="https://gitlab.dune-project.org/core/${PN}/repository/archive.tar.gz?ref=${PV} -> ${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gmp mpi vc"

DEPEND="dev-util/pkgconfig
		doc? ( app-doc/doxygen
			   dev-python/sphinx
               media-gfx/inkscape
			   virtual/imagemagick-tools
               virtual/latex-base )
		gmp? ( dev-libs/gmp )
		mpi? ( virtual/mpi )
        vc? ( dev-libs/vc )"
RDEPEND="${DEPEND}"

src_unpack() {
  unpack ${A}
  mv ${WORKDIR}/${PN}-* ${WORKDIR}/${P}
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"

  # CMake flags that need to go into DUNE_CMAKE_FLAGS
  local mycmakeargs=(
	  -DBUILD_SHARED_LIBS=ON
	  $(cmake-utils_use_find_package gmp GMP)
	  $(cmake-utils_use_find_package mpi MPI)
	  $(cmake-utils_use_find_package vc Vc)
    )

  # generate env.d file
  ENVFILE=${WORKDIR}/98${PN}
  echo 'SPACE_SEPARATED=DUNE_CMAKE_FLAGS' > ${ENVFILE}
  echo 'COLON_SEPARATED=DUNE_CONTROL_PATH' >> ${ENVFILE}
  echo 'DUNE_CONTROL_PATH=/usr' >> ${ENVFILE}
  printf 'DUNE_CMAKE_FLAGS="' >> ${ENVFILE}
  printf ' %s' "${mycmakeargs[@]}" >> ${ENVFILE}
  printf '"\n' >> ${ENVFILE}

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
  doenvd ${WORKDIR}/98${PN}
}
