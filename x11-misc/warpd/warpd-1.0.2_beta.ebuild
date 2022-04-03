# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A modal keyboard-driven virtual pointer"
HOMEPAGE="https://github.com/rvaiya/warpd"
SRC_URI="https://github.com/rvaiya/${PN}/archive/v1.0.2-beta.tar.gz -> ${P}-v1.02.-beta.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/libXinerama
		x11-libs/libXft
		x11-libs/libXfixes
		x11-libs/libXtst
		x11-libs/libX11"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/python:3"


src_compile() {
	emake
}
