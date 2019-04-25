# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A helper library and tools for Active Directory client operations"
HOMEPAGE="https://www.freedesktop.org/software/realmd/adcli/"
SRC_URI="https://www.freedesktop.org/software/realmd/releases/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND="
		app-crypt/mit-krb5
		dev-libs/cyrus-sasl
		net-nds/openldap
	"
DEPEND="
		${RDEPEND}
		doc? (
				app-text/docbook-xml-dtd:4.3
				dev-libs/libxslt
			)
	"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable doc)
}
