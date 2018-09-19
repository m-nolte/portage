# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

UPSTREAM_VERSION="${PV/_rc/-rc.}"

DESCRIPTION="PowerShell Core is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models."
HOMEPAGE="https://docs.microsoft.com/en-us/powershell/"
SRC_URI="https://github.com/PowerShell/PowerShell/releases/download/v${UPSTREAM_VERSION}/powershell-${UPSTREAM_VERSION}-linux-x64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	app-crypt/mit-krb5
	dev-libs/icu
	dev-libs/openssl
	dev-util/lttng-ust
	net-misc/curl
	sys-apps/util-linux
	sys-libs/libunwind
	sys-libs/pam
	sys-libs/zlib
"

QA_PREBUILT="opt/microsoft/powershell/${PV}/*"

S=${WORKDIR}/${PV}

src_unpack() {
	mkdir -p "${S}"
	cd ${S}
	unpack ${A}
}

src_install() {
	PSHOME="/opt/microsoft/powershell/${PV}"
	echo "PSHOME=\"${PSHOME}\"" >> ${WORKDIR}/${PN}.env

	insinto "/opt/microsoft/powershell"
	doins -r "${S}"
	fperms 755 "${PSHOME}/pwsh"

	dodir "/opt/bin"
	dosym ${PSHOME}/pwsh /opt/bin/pwsh

	doenvd ${WORKDIR}/${PN}.env
}
