# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user

DESCRIPTION="DavMail POP/IMAP/SMTP/Caldav/Carddav/LDAP Exchange Gateway"
HOMEPAGE="http://davmail.sourceforge.net/"
REV="2438"
MY_PN="${PN}"
MY_P="${MY_PN}-${PV}"
ARCH=`uname -m`

URL_32="mirror://sourceforge/${MY_PN}/${MY_PN}-linux-x86-${PV}-${REV}.tgz"
URL_64="mirror://sourceforge/${MY_PN}/${MY_PN}-linux-x86_64-${PV}-${REV}.tgz"

SRC_URI="
	amd64? ( "${URL_64}" )
	x86? ( "${URL_32}" )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/"${MY_PN}"/"${MY_PN}"-linux-"${ARCH}"-"${PV}"-"${REV}"/ "${WORKDIR}"/"${PN}"
}

src_install () {

	local TARGETDIR="/opt/davmail"
	dodir "${TARGETDIR}"
	insinto "${TARGETDIR}"/

	doins -r $"{S}"/"${MY_PN}"-linux-"${ARCH}"-"${PV}"-"${REV}"/*  || die "Install failed!"

	fowners root:users -R "${TARGETDIR}" || die "Could not change ownership of /opt/davmail directory."

	insinto /usr/share/pixmaps
	#doins "${FILESDIR}"/davmail.png || die "Could not copy davmail.png"

	return
}

pkg_postinst() {
	#xdg-desktop-menu install "${FILESDIR}"/abadonna-davmail.desktop || die "Could not register a menu item"

	chmod 755 /opt/davmail/davmail.sh || die "Could not set file permissions on davmail.sh file"

	return
}

pkg_postrm() {
	xdg-desktop-menu uninstall "${FILESDIR}"/abadonna-davmail.desktop || die "Could not de-register a menu item"

	return
}
