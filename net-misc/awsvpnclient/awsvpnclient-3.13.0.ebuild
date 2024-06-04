# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop wrapper unpacker xdg

DESCRIPTION="AWS VPN Client"
HOMEPAGE="https://aws.amazon.com/vpn/"

SRC_URI="
	amd64? (  https://d20adtppz83p9s.cloudfront.net/GTK/${PV}/awsvpnclient_amd64.deb )"
LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

PATCHES=(
	"${FILESDIR}"/run-time-config.patch
)

RDEPEND="
	x11-libs/gtk+
	x11-libs/cairo
	x11-libs/pango
	>=dev-libs/openssl-3.0.13
	"

DEPEND=""

S="${WORKDIR}"

src_unpack() {
	cd "${S}"
	unpack_deb "${DEB_NAME}"
}

src_install() {

	insinto /opt/
	doins -r opt/*
	exeinto /opt/${PN}
	doexe opt/awsvpnclient/'AWS VPN Client'
	insinto /etc/
	doins -r etc/*
	insinto /usr/
	doins -r usr/*

	make_wrapper ${PN} "/opt/${PN}/AWS\ VPN\ Client" /opt/${PN}
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
