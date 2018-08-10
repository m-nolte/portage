# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop xdg-utils

DESCRIPTION="SoftMaker FreeOffice is a complete office suite."
HOMEPAGE="http://www.freeoffice.com/"
#KEYWORDS="~amd64 ~x86"
KEYWORDS="~amd64"

declare -A ARCH_FILES
ARCH_FILES[amd64]="${P}-amd64.tgz"
ARCH_FILES[x86]="${P}-i386.tgz"

for keyword in ${KEYWORDS} ; do
  SRC_URI+=" ${keyword#\~}? ( ${ARCH_FILES[${keyword#\~}]} )"
done

LICENSE="softmaker-freeoffice"
SLOT="0"
IUSE=""
RESTRICT="fetch"

DEPEND=""
RDEPEND="
	media-fonts/crosextrafonts-caladea
	media-fonts/crosextrafonts-carlito
	dev-libs/libbsd
	dev-libs/openssl
	net-misc/curl
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/zlib
	virtual/opengl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libxcb
"

S=${WORKDIR}
QA_PREBUILT="*"

pkg_nofetch() {
	einfo "Please download ${ARCH_FILES[${ARCH}]} and from ${HOMEPAGE}"
	einfo "and move it to your distfiles directory."
}

src_install() {
  APPDIR=/usr/share/freeoffice2018

  # extract application
  mkdir -p ${D}/${APPDIR}
  tar -x -f ${WORKDIR}/freeoffice2018.tar.lzma -C ${D}/${APPDIR} || die

  # install scripts to /usr/bin
  dobin ${FILESDIR}/textmaker18
  dobin ${FILESDIR}/planmaker18
  dobin ${FILESDIR}/presentations18

  # install icons
  for SIZE in 16 24 32 48 64 72 128 256 512 ; do
	for APP in prl tml pml ; do
      newicon -s ${SIZE} -c apps ${D}/${APPDIR}/icons/${APP}_${SIZE}.png application-x-${APP}18.png
	done
  done

  for SIZE in 16 32 48 64 128 ; do
	for MIME in application-x-tmd application-x-tmv ; do
	  newicon -s ${SIZE} -c mimetypes ${D}/${APPDIR}/icons/tmd_${SIZE}.png ${MIME}.png
	done
	for MIME in application-x-pmd application-x-pmv application-x-pmdx ; do
	  newicon -s ${SIZE} -c mimetypes ${D}/${APPDIR}/icons/pmd_${SIZE}.png ${MIME}.png
	done
	for MIME in application-x-prd application-x-prs application-x-prv ; do
	  newicon -s ${SIZE} -c mimetypes ${D}/${APPDIR}/icons/prd_${SIZE}.png ${MIME}.png
	done
  done

  # install desktop files
  insinto /usr/share/applications
  doins ${FILESDIR}/freeoffice-2018-textmaker.desktop
  doins ${FILESDIR}/freeoffice-2018-planmaker.desktop
  doins ${FILESDIR}/freeoffice-2018-presentations.desktop

  # register mime types
  # Note: this is a stripped-down version of the original registration file
  insinto /usr/share/mime/packages
  doins ${FILESDIR}/softmaker-freeoffice-2018.xml

  # remove some unnecessary files
  rm -rf ${D}/${APPDIR}/mime
  rm -rf ${D}/${APPDIR}/icons
  rm -f ${D}/${APPDIR}/fonts/Caladea-*.ttf
  rm -f ${D}/${APPDIR}/fonts/Carlito-*.ttf
}

pkg_postinst() {
  xdg_desktop_database_update
  xdg_mimeinfo_database_update
}

pkg_postrm() {
  xdg_desktop_database_update
  xdg_mimeinfo_database_update
}
