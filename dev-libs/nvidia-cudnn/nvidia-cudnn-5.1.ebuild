# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="NVIDIA cuDNN GPU Accelerated Deep Learning"
HOMEPAGE="https://developer.nvidia.com/cuDNN"
SRC_URI="http://developer.download.nvidia.com/compute/redist/cudnn/v5.1/cudnn-8.0-linux-x64-v${PV}.tgz -> ${P}.tgz"

LICENSE="NVIDIA-cuDNN"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-util/nvidia-cuda-toolkit-8.0*"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /opt
	cp -pPR cuda ${ED}/opt || die
}
