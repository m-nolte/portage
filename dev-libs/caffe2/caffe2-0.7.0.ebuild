# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1

DESCRIPTION="A New Lightweight, Modular, and Scalable Deep Learning Framework"
HOMEPAGE="https://caffe2.ai"
SRC_URI="https://github.com/caffe2/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda leveldb mpi opencv openmp python threads"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	>=dev-cpp/eigen-3.3
	dev-cpp/gflags
	dev-cpp/glog
	dev-libs/protobuf
	cuda? ( dev-libs/nvidia-cudnn
			dev-util/nvidia-cuda-toolkit )
	leveldb? ( dev-libs/leveldb )
	mpi? ( virtual/mpi )
	opencv? ( media-libs/opencv )
    python? ( dev-libs/pybind11
			  dev-python/numpy[${PYTHON_USEDEP}]
			  dev-python/protobuf-python[${PYTHON_USEDEP}]
			  ${PYTHON_DEPS} )
"
RDEPEND="${DEPEND}"

pkg_setup() {
  use python && python-single-r1_pkg_setup
}

src_prepare() {
  epatch ${FILESDIR}/cmake-find-Eigen3.patch

  default
}

src_configure() {
  CMAKE_BUILD_TYPE="Release"
  local mycmakeargs=(
	  -DBUILD_PYTHON="$(usex python ON OFF)"
	  -DBUILD_TEST="OFF"
	  -DUSE_CUDA="$(usex cuda ON OFF)"
	  -DUSE_GLOO="OFF"
	  -DUSE_LEVELDB="$(usex leveldb ON OFF)"
	  -DUSE_LMDB="OFF"
	  -DUSE_MPI="$(usex mpi ON OFF)"
	  -DUSE_NCCL="OFF"
	  -DUSE_NNPACK="OFF"
	  -DUSE_OPENMP="$(usex openmp ON OFF)"
	  -DUSE_ROCKSDB="OFF"
	  -DUSE_THREADS="$(usex threads ON OFF)"
	)

  cmake-utils_src_configure
}
