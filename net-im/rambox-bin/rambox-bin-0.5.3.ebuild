# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils unpacker gnome2-utils xdg

DESCRIPTION="Messaging and emailing app that combines common web apps into one."
HOMEPAGE="http://rambox.pro"

DEB_NAME="Rambox_${PV}-x64.deb"
SRC_URI="
	amd64? ( https://github.com/saenzramiro/rambox/releases/download/${PV}/${DEB_NAME} )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack_deb ${DEB_NAME}
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} .
	#newmenu usr/share/applications/Rambox.desktop rambox-bin.desktop
	insinto /opt/${PN}
	local size
	for size in 16 32 48 64 128 256 512; do
		newicon -s "${size}" \
			"usr/share/icons/hicolor/${size}x${size}/apps/rambox.png" \
			rambox.png
	done
	doins -r opt/Rambox/*
	dosym /opt/rambox-bin/rambox /opt/rambox-bin/rambox-bin

	fperms +x /opt/rambox-bin/rambox
	make_desktop_entry rambox rambox-bin /usr/share/icons/hicolor/16x16/apps/rambox.png
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
