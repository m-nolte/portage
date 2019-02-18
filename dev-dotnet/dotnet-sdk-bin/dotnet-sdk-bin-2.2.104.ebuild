# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION=".NET Core SDK"
HOMEPAGE="https://www.microsoft.com/net"
LICENSE="MIT"

SRC_URI="
	amd64? ( elibc_glibc? ( https://download.visualstudio.microsoft.com/download/pr/69937b49-a877-4ced-81e6-286620b390ab/8ab938cf6f5e83b2221630354160ef21/dotnet-sdk-2.2.104-linux-x64.tar.gz ) )
	amd64? ( elibc_musl? ( https://download.visualstudio.microsoft.com/download/pr/8e67400a-b129-4e0c-ae7a-eed7fd123cf6/9ebd9ad8e5fd9e2eaec1f7fbc66323b5/dotnet-sdk-2.2.104-linux-musl-x64.tar.gz ) )
	arm? ( https://download.visualstudio.microsoft.com/download/pr/d9f37b73-df8d-4dfa-a905-b7648d3401d0/6312573ac13d7a8ddc16e4058f7d7dc5/dotnet-sdk-2.2.104-linux-arm.tar.gz )
	arm64? ( https://download.visualstudio.microsoft.com/download/pr/2b201001-7074-476a-aa83-b5194c660a59/68233f3c3f16c97767a77216ec1f6e70/dotnet-sdk-2.2.104-linux-arm64.tar.gz )
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
