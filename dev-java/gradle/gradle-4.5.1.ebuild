# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2

STAGE0="${P}-bin.zip"

DESCRIPTION="Gradle is a build tool with a focus on build automation and support for multi-language development."
HOMEPAGE="https://gradle.org"
SRC_URI="
	http://services.gradle.org/distributions/${P}-src.zip
	http://services.gradle.org/distributions/${STAGE0}
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc"

RDEPEND=">=virtual/jdk-1.5"
DEPEND="${RDEPEND}"

src_unpack() {
  unpack ${P}-src.zip
}

src_prepare() {
  default
  java-pkg-2_src_prepare

  sed -i -e "/^distributionUrl=/cdistributionUrl=file://${DISTDIR}/${STAGE0}" gradle/wrapper/gradle-wrapper.properties || die 'Unable to fix stage0 url'
}

src_compile() {
  ./gradlew --gradle-user-home "${WORKDIR}" "$(usex doc installAll install)" -Pgradle_installPath=dist || die 'Gradle build failed'
}

src_install() {
  gradle_dir="${EROOT}usr/share/${PN}"

  cd dist || die
  dodoc NOTICE

  insinto "${gradle_dir}"
  cd lib || die
  for jar in *.jar ; do
	java-pkg_newjar ${jar} ${jar}
  done

  cd plugins || die
  java-pkg_jarinto ${JAVA_PKG_JARDEST}/plugins
  for jar in *.jar ; do
	java-pkg_newjar ${jar} ${jar}
  done

  java-pkg_dolauncher "${PN}" --main org.gradle.launcher.GradleMain --java_args "-Dgradle.home=${gradle_dir}/lib \${GRADLE_OPTS}"
}
