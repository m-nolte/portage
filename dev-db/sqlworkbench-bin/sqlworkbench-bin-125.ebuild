# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE=""

inherit java-pkg-2 xdg-utils

DESCRIPTION="SQL Workbench/J is a free, DBMS-independent, cross-platform SQL query tool."
HOMEPAGE="https://www.sql-workbench.eu"
SRC_URI="https://www.sql-workbench.eu/Workbench-Build${PV}-with-optional-libs.zip -> ${P}.zip"

LICENSE="sql-workbench"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.8:*"
RDEPEND="
	${DEPEND}
	dev-java/log4j:0
	dev-java/xerces:2
	"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	java-pkg_dojar sqlworkbench.jar

	java-pkg_dojar ext/jna.jar ext/jna-platform.jar
	java-pkg_dojar ext/resolver.jar ext/serializer.jar
	java-pkg_dojar ext/odfdom-java.jar ext/simple-odf.jar
	java-pkg_dojar ext/poi.jar ext/poi-ooxml.jar ext/poi-ooxml-schemas.jar
	java-pkg_dojar ext/xml-apis.jar ext/xmlbeans.jar
	java-pkg_dojar ext/commons-codec.jar ext/commons-collections4.jar ext/commons-compress.jar

	java-pkg_register-dependency log4j,xerces-2

	java-pkg_register-optional-dependency jdbc-informix,jdbc-mssqlserver,jdbc-mysql,jdbc-postgresql,jdts

	java-pkg_dolauncher sqlworkbench --main workbench.WbStarter --java_args="-Dvisualvm.display.name=SQLWorkbench -Dawt.useSystemAAFontSettings=on"
	java-pkg_dolauncher sqlworkbench-console --main workbench.console.SQLConsole --java_args="-Djava.awt.headless=true -Dvisualvm.display.name=SQLWorkbench"

	newicon -s 32 -c apps workbench32.png sqlworkbench.png
	make_desktop_entry sqlworkbench "SQL Workbench/J" sqlworkbench "Development" "StartupNotify=true"
}
