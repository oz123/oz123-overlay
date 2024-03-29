# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop wrapper unpacker xdg

DESCRIPTION="The GUI for MongoDB."
HOMEPAGE="https://github.com/mongodb-js/compass"

SRC_URI="
	amd64? ( https://downloads.mongodb.com/compass/mongodb-compass_${PV}_amd64.deb )"
LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="
	gnome-base/dconf
	"

DEPEND=""

S="${WORKDIR}"

src_unpack() {
	cd "${S}"
	unpack_deb "${DEB_NAME}"
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} .
	insinto /opt/${PN}
	newicon "usr/share/pixmaps/${PN}.png" ${PN}.png
	doins -r usr/*

	make_desktop_entry ${PN} ${PN} "/usr/share/icons/${PN}.png"
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
