# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2 xdg-utils

DESCRIPTION="Client application for the BwLehrpool teaching platform"
HOMEPAGE="https://www.bwlehrpool.de"
SRC_URI="https://bwlp-masterserver.ruf.uni-freiburg.de/dozmod/4/${PN}.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.7"
BDEPEND=""

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}/
}

src_install() {
	java-pkg_dojar ${S}/${PN}.jar
	java-pkg_dolauncher ${PN} --jar ${PN}.jar
	doicon -s 128 -c apps ${FILESDIR}/${PN}.png
	make_desktop_entry "${PN}" "BwLehrpool" "${PN}" "Utility"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
