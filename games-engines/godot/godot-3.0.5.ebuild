# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 python3_6 )
SCONS_MIN_VERSION=3.0

inherit eutils scons-utils

DESCRIPTION="2D and 3D cross-platform game engine"
HOMEPAGE="https://godotengine.org"
SRC_URI="https://github.com/godotengine/godot/archive/${PV}-stable.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+3d +advanced-gui deprecated +editor-splash +gdscript +minizip pulseaudio +tools +touch udev +xml"

DEPEND="
	dev-libs/libpcre2[pcre32]
	dev-libs/openssl
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/libogg
	media-libs/libpng
	media-libs/libtheora
	media-libs/libvorbis
	media-libs/libvpx
	media-libs/libwebp
	media-libs/mesa[gles2]
	media-libs/opus
	net-libs/enet
	sys-libs/zlib
	virtual/glu
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
	pulseaudio? ( media-sound/pulseaudio )
	touch? ( x11-libs/libXi )
	udev? ( virtual/udev )
"
# The following dependencies cannot be satisfied right now:
# - >=sci-physics/bullet-2.88
#	There is no corresponding ebuild in the main portage tree
# - >=app-arch/zstd-1.3.2
#   Godot uses experimental features which require static linking
#	(see https://github.com/godotengine/godot/issues/17374)
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-stable"

src_configure() {
	MYSCONS=(
		platform=x11
		tools="$(usex tools)"
		target="$(usex tools release_debug release)"
		pulseaudio="$(usex pulseaudio)"
		udev="$(usex udev)"
		touch="$(usex touch)"
		deprecated="$(usex deprecated)"
		gdscript="$(usex gdscript)"
		minizip="$(usex minizip)"
		xml="$(usex xml)"
		disable_3d="$(usex 3d no yes)"
		disable_advanced_gui="$(usex advanced-gui no yes)"
		builtin_bullet=yes
		builtin_freetype=no
		builtin_enet=no
		builtin_libogg=no
		builtin_libpng=no
		builtin_libtheora=no
		builtin_libvorbis=no
		builtin_libvpx=no
		builtin_libopenssl=no
		builtin_libwebp=no
		builtin_opus=no
		builtin_pcre2=no
		builtin_recast=yes
		builtin_squish=yes
		builtin_thekla_atlas=yes
		builtin_zlib=no
		builtin_zstd=yes
		no_editor_splash="$(usex editor-splash no yes)"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
	)
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	newicon icon.svg ${PN}.svg
	dobin bin/godot.*
	if [[ "${ARCH}" == "amd64" ]]; then
		make_desktop_entry godot.x11.tools.64 Godot
	elif [[ "${ARCH}" == "x86" ]]; then
		make_desktop_entry godot.x11.tools.32 Godot
	else
		elog "Couldn't detect running architecture to create a desktop file."
	fi
}
