# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

MY_PV=$(ver_rs 3 '.v')-M14

DESCRIPTION="Apache Directory Studio is a complete directory tooling platform intended to be used with any LDAP server."
HOMEPAGE="https://directory.apache.org/studio/"
SRC_URI="
	amd64? ( https://www-eu.apache.org/dist/directory/studio/${MY_PV}/${PN}-${MY_PV}-linux.gtk.x86_64.tar.gz )
	x86? ( https://www-eu.apache.org/dist/directory/studio/${MY_PV}/${PN}-${MY_PV}-linux.gtk.x86.tar.gz )
	"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	>=virtual/jre-1.8.0
	x11-libs/gtk+:2
	"
BDEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	insinto "/opt/${PN}"
	doins -r *
	fperms +x "/opt/${PN}/${PN}"
	dosym "/opt/${PN}/${PN}" "/usr/bin/${PN}"
	newicon ${S}/features/org.apache.directory.studio.schemaeditor.feature_${MY_PV}/studio.png ${PN}.png
	make_desktop_entry "${PN}" "Apache Directory Studio" "${PN}" "System"
}
