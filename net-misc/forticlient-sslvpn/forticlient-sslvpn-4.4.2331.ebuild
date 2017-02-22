# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils unpacker xdg gnome2-utils

DESCRIPTION="The forticlient-sslvpn client to connect to fortigate firewalls"
HOMEPAGE="fortinet"
SRC_URI="https://hadler.me/files/${PN}_${PV}-1_amd64.deb"

LICENSE="fortinet"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack (){
	unpack_deb ${PN}_${PV}-1_amd64.deb
}

src_install() {
	insinto /opt/
	doins -r opt/*
	fperms +x /opt/${PN}/forticlientsslvpn.sh
	fperms +x /opt/${PN}/fortisslvpn.sh
	fperms +x /opt/forticlient-sslvpn/64bit/forticlientsslvpn
	fperms +x /opt/forticlient-sslvpn/64bit/forticlientsslvpn_cli
	fperms +x /opt/forticlient-sslvpn/64bit/helper/setup.linux.sh
	fperms +x /opt/forticlient-sslvpn/64bit/helper/waitppp.sh

	newmenu usr/share/applications/${PN}.desktop ${PN}.desktop

	elog "You need to accept the EULA"
	elog "Run /opt/forticlient-sslvpn/64bit/helper/setup.linux.sh "
	elog "to do this"
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
