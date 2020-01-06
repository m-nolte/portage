# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="DBeaver is free and open source universal database tool for developers and database administrators."
HOMEPAGE="https://dbeaver.io"
SRC_URI="https://github.com/dbeaver/dbeaver/releases/download/${PV}/dbeaver-ce-${PV}-linux.gtk.x86_64.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
BDEPEND=""
RDEPEND=">=virtual/jdk-1.8:*"

RESTRICT="mirror strip test"

S="${WORKDIR}/dbeaver"

src_install() {
	local install_dir="/opt/dbeaver"

	insinto "${install_dir}"
	doins -r *

	fperms a+x "${install_dir}/dbeaver"
	dosym "${install_dir}/dbeaver" "/usr/bin/dbeaver"

	newicon -s 128 -c apps dbeaver.png dbeaver.png

	local -a desktop_entry_extras=(
		"MimeType=application/x-sqlite3;application/sql;"
		"StartupWMClass=DBeaver"
		"StartupNotify=true"
		"GenericName=Universal Database Manager"
	)
	make_desktop_entry dbeaver "DBeaver" dbeaver "Development" "$(printf '%s\n' "${desktop_entry_extras[@]}")"
}
