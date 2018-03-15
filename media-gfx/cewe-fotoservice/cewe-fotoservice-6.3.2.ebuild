# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop xdg-utils

SRC_HOST="dls.photoprintit.com"

DESCRIPTION="CEWE Fotobuch Bestellsoftware"
HOMEPAGE="https://cewe.de"
SRC_URI="
  x86? ( http://${SRC_HOST}/download/Data/6822-de_DE/hps/38-linuxexe-6.3.2_836524e0efd398ec6339169575f1206b.zip )
  amd64? ( http://${SRC_HOST}/download/Data/6822-de_DE/hps/38-linuxexe64-6.3.2_828848301f619b159e398603d67f5516.zip )
  x86? ( http://${SRC_HOST}/download/Data/generic-data/hps/38-linuxlib-6.3.2_54205ab3ca3074aadea52b753919ffb3.zip )
  amd64? ( http://${SRC_HOST}/download/Data/generic-data/hps/38-linuxlib64-6.3.2_13a163fa56de602b215a48d07d7f3b80.zip )
  http://${SRC_HOST}/download/Data/6822-de_DE/hps/38-resources-6.3.2_af240c81af3f1365bb1306044f77089a.zip
  http://${SRC_HOST}/download/Data/6822-de_DE/hps/38-startscreen-6.3.2_e63f17525b6b2df244aec1fe95160162.zip
  http://${SRC_HOST}/download/Data/6822-de_DE/hps/38-photofun-6.3.2_2b31939d5f3e1e7c1fcf50f393f47cf4.zip
  http://${SRC_HOST}/download/Data/generic-data/hps/38-decorations-6.3.2_98008d396297f4a42be1eb0656efb493.zip
  http://${SRC_HOST}/download/Data/generic-data/hps/38-backgrounds-6.3.2_5da606bcdcbdb89e9fd84a5cd117a350.zip
  http://${SRC_HOST}/download/Data/generic-data/hps/38-svgcalendars-6.3.2_47b2c4a635f7c90bbf00b1ffa02644b3.zip
  http://${SRC_HOST}/download/Data/generic-data/hps/38-svgtemplates-6.3.2_33a51d20421d3f03a028067932d7eb88.zip
"

LICENSE="cewe-fotoservice"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="bindist mirror strip"

DEPEND="
  app-arch/zip
"
RDEPEND="
  dev-qt/qtconcurrent:5
  dev-qt/qtcore:5
  dev-qt/qtdbus:5
  dev-qt/qtgui:5
  dev-qt/qtmultimedia:5
  dev-qt/qtnetwork:5
  dev-qt/qtopengl:5
  dev-qt/qtprintsupport:5
  dev-qt/qtsvg:5
  dev-qt/qtwebchannel:5
  dev-qt/qtwebengine:5
  dev-qt/qtwebsockets:5
  dev-qt/qtwidgets:5
  dev-qt/qtxml:5
  media-libs/sampleicc
  media-video/ffmpeg
  sys-devel/gcc
  sys-libs/glibc
  sys-libs/zlib
  virtual/opencl
"

# dependencies on old libraries
# - app-text/hunspell (1.4)
# - media-gfx/exiv2 (0.14)

INSTALLDIR=/opt/${PN}

CEWELIBS="
  libCWAPM.so
  libCWAssistant.so
  libCWAutoBook.so
  libCWCalendar.so
  libCWCore.so
  libCWCustomer.so
  libCWDlPortal.so
  libCWFotoEditor.so
  libCWFotoExplorer.so
  libCWFotoPlus.so
  libCWFoto.so
  libCWGeoLocation.so
  libCWGUIWidgets.so
  libCWImageCutter.so
  libCWImageLoader.so
  libCWImageProcessing.so
  libCWImporter.so
  libCWModelBase.so
  libCWModel.so
  libCWMyPhotos.so
  libCWNetworking.so
  libCWNetworkingXTCI.so
  libCWOpenCL.so
  libCWProductBase.so
  libCWProductDialogs.so
  libCWProductProperties.so
  libCWRegionOfInterest.so
  libCWStartScreen.so
  libCWTemplates.so
  libCWVideoAnalysis.so
  libCWXML.so
"

QA_PREBUILT="*"

S=${WORKDIR}
ICONSIZES="16 22 24 32 48 64 128 256"

src_prepare() {
  # remove bundeled Qt5
  rm ${S}/libQt5*.so.*
  rm ${S}/libqgsttools_p.so.*
  rm ${S}/QtWebEngineProcess
  rm -rf ${S}/iconengines
  rm -rf ${S}/imageformats
  rm -rf ${S}/mediaservice
  rm -rf ${S}/platforminputcontexts
  rm -rf ${S}/platforms
  rm -rf ${S}/printsupport
  rm -rf ${S}/resources_qt
  rm -rf ${S}/xcbglintegrations
  rm ${S}/qt.conf

  # add symlinks to Qt5 plugins
  ln -ns /usr/lib/qt5/libexec/QtWebEngineProcess ${S}
  ln -ns /usr/lib/qt5/plugins/iconengines ${S}
  ln -ns /usr/lib/qt5/plugins/imageformats ${S}
  ln -ns /usr/lib/qt5/plugins/mediaservice ${S}
  ln -ns /usr/lib/qt5/plugins/platforminputcontexts ${S}
  ln -ns /usr/lib/qt5/plugins/platforms ${S}
  ln -ns /usr/lib/qt5/plugins/printsupport ${S}
  ln -ns /usr/share/qt5/resources ${S}/resources_qt
  ln -ns /usr/lib/qt5/plugins/xcbglintegrations ${S}

  # remove further bundled libraries
  rm ${S}/libav*.so.*
  #rm ${S}/libexiv2.so.*
  #rm ${S}/libhunspell-1.4.so.*
  rm ${S}/libOpenCL.so.*
  rm ${S}/libSampleICC.so.*
  rm ${S}/libsw*.so.*

  default
}

src_compile() {
  ${S}/IconExtractor ${S}/Resources/keyaccount/32.ico ${ICONSIZES}
}

src_install() {
  # install executables
  exeinto ${INSTALLDIR}
  doexe "CEWE FOTOSCHAU"
  doexe "CEWE FOTOIMPORTER"
  doexe "cewe-fotoservice.de"
  doexe "gpuprobe"

  # install libraries
  exeinto ${INSTALLDIR}
  for lib in ${CEWELIBS} ; do
	doexe ${lib}.0.1.0
  done
  doexe "libexiv2.so.14.0.0"
  doexe "libhunspell-1.4.so.0.0.0"
  doexe "libredeye.so"
  doexe "libPerfectlyClearPro_v7370_fb.so"

  # symlinks for libraries
  for lib in ${CEWELIBS} ; do
	dosym ${INSTALLDIR}/${lib}.0.1.0 ${INSTALLDIR}/${lib}.0
  done
  dosym ${INSTALLDIR}/libexiv2.so.14.0.0 ${INSTALLDIR}/libexiv2.so.14
  dosym ${INSTALLDIR}/libhunspell-1.4.so.0.0.0 ${INSTALLDIR}/libhunspell-1.4.so.0

  # install order processors
  exeinto ${INSTALLDIR}/orderprocessors
  doexe "orderprocessors/libCWOrderProcessorBOL.so"
  doexe "orderprocessors/libCWOrderProcessorKruidvat.so"

  # install Qt symlinks
  dosym /usr/lib/qt5/libexec/QtWebEngineProcess ${INSTALLDIR}/QtWebEngineProcess
  dosym /usr/lib/qt5/plugins/iconengines ${INSTALLDIR}/iconengines
  dosym /usr/lib/qt5/plugins/imageformats ${INSTALLDIR}/imageformats
  dosym /usr/lib/qt5/plugins/mediaservice ${INSTALLDIR}/mediaservice
  dosym /usr/lib/qt5/plugins/platforminputcontexts ${INSTALLDIR}/platforminputcontexts
  dosym /usr/lib/qt5/plugins/platforms ${INSTALLDIR}/platforms
  dosym /usr/lib/qt5/plugins/printsupport ${INSTALLDIR}/printsupport
  dosym /usr/share/qt5/resources ${INSTALLDIR}/resources_qt
  dosym /usr/lib/qt5/plugins/xcbglintegrations ${INSTALLDIR}/xcbglintegrations

  insinto ${INSTALLDIR}
  doins -r Resources

  # install icons
  for size in ${ICONSIZES} ; do
	newicon -s ${size} cewe_${size}.png cewe-fotoservice.png
  done

  # create desktop entry
  make_desktop_entry "${INSTALLDIR}/cewe-fotoservice.de" "CEWE Fotoservice" "cewe-fotoservice" "Graphics" "MimeType=application/x-hps-${PV}-mcf"
}

pkg_postinst() {
  xdg_desktop_database_update
}

pkg_postrm() {
  xdg_desktop_database_update
}
