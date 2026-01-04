# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A tiny wake-on-lan tool"
HOMEPAGE="https://github.com/oz123/urr"
SRC_URI="https://github.com/oz123/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
"
src_unpack() {
	default
}


src_compile() {
	emake all
	emake man
}

src_install() {
	dobin urr
	doman docs/urr.1
}
