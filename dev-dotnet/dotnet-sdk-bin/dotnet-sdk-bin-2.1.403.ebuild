# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION=".NET Core SDK"
HOMEPAGE="https://www.microsoft.com/net"
LICENSE="MIT"

SRC_URI="
	amd64? ( elibc_glibc? ( https://download.visualstudio.microsoft.com/download/pr/e85de743-f80b-481b-b10e-d2e37f05a7ce/0bf3ff93417e19ad8d6b2d3ded84d664/dotnet-sdk-2.1.403-linux-x64.tar.gz ) )
	amd64? ( elibc_musl? ( https://download.visualstudio.microsoft.com/download/pr/527fff7b-1862-4d2e-ab78-94c6cca188bc/8c62477e25ac1448c93ed4a8da11cc37/dotnet-sdk-2.1.403-linux-musl-x64.tar.gz ) )
	arm? ( https://download.visualstudio.microsoft.com/download/pr/10b96626-02d8-415a-be85-051a2a48d0c2/5ec51d3d9f092ba558fb5f1f03d26699/dotnet-sdk-2.1.403-linux-arm.tar.gz )
	arm64? ( https://download.visualstudio.microsoft.com/download/pr/00038a67-bb86-4c39-88df-7c0998002a9e/97de51fd691c68e18ddd3dcaf3d60181/dotnet-sdk-2.1.403-linux-arm64.tar.gz )
"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

RDEPEND="
	>=sys-apps/lsb-release-1.4
	>=sys-devel/llvm-4.0
	>=dev-util/lldb-4.0
	>=sys-libs/libunwind-1.1-r1
	>=dev-libs/icu-57.1
	>=dev-util/lttng-ust-2.8.1
	>=dev-libs/openssl-1.0.2h-r2
	>=net-misc/curl-7.49.0
	>=app-crypt/mit-krb5-1.14.2
	>=sys-libs/zlib-1.2.8-r1
	elibc_musl? ( >=dev-libs/libintl-0.19.8.1 )
"

QA_PREBUILT="*"

S=${WORKDIR}

src_install() {
	local dest="opt/dotnet_core"
	dodir "${dest}"

	local ddest="${D}${dest}"
	cp -a "${S}"/* "${ddest}/" || die
	dosym "/${dest}/dotnet" "/usr/bin/dotnet"
}
