# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker gnome2-utils xdg

DESCRIPTION="The best email app for people and teams at work"
HOMEPAGE="https://github.com/nylas-mail-lives/nylas-mail"

DEB_NAME="nylas-${PV}-amd64.deb"
SRC_URI="
	amd64? ( https://github.com/nylas-mail-lives/nylas-mail/releases/download/${PV}-4alpha/nylas-${PV}-amd64.deb )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND=""

DEPEND="(
	gnome-base/libgnome-keyring
	)"

S=${WORKDIR}

src_unpack() {
	unpack_deb ${DEB_NAME}
}

src_install() {
	insinto /usr/
	doins -r usr/*
	fperms +x /usr/bin/nylas-mail
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
