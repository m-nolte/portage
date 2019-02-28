# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2 xdg-utils

DESCRIPTION="File sharing cloud service for universities in Baden-Württemberg"
HOMEPAGE="https://bwsyncandshare.kit.edu"
SRC_URI="https://download.bwsyncandshare.kit.edu/clients/bwSyncAndShare_Latest_Linux.tar.gz"

LICENSE="PowerFolder"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.7"
BDEPEND=""

S=${WORKDIR}/${PN}

src_prepare() {
	default
	sed -e 's:^CLIENT_INSTALL=.$:CLIENT_INSTALL=/usr/share/bwSyncAndShare/lib:g' \
		-e 's:\$CLIENT_INSTALL/jre/bin/java:java:g' \
		${S}/bwSyncAndShare-Client.sh > ${S}/bwSyncAndShare-Client
}

src_install() {
	java-pkg_dojar ${S}/${PN}.jar
	dobin bwSyncAndShare-Client
	dodoc README
	doicon -s 128 -c apps install-files/${PN}.png
	make_desktop_entry "bwSyncAndShare-Client" "bwSync&Share" "${PN}" "Network" "StartupNotify=true"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
