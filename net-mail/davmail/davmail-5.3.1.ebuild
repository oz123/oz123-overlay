# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit user linux-info

DESCRIPTION="DavMail POP/IMAP/SMTP/Caldav/Carddav/LDAP Exchange Gateway"
HOMEPAGE="http://davmail.sourceforge.net/"
KERNEL="linux"
REV="3079"

SRC_URI="https://downloads.sourceforge.net/project/davmail/davmail/5.3.1/davmail-5.3.1-3079.zip"

MY_PN="${PN}"
MY_P="${MY_PN}-${PV}"

ARCH="amd64"

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
}

src_install () {

	local TARGETDIR="/opt/davmail"
	dodir "${TARGETDIR}"
	insinto "${TARGETDIR}"/

	doins -r "${S}"/* || die "Install failed!"

	fowners root:users -R "${TARGETDIR}" || die "Could not change ownership of /opt/davmail directory."

	insinto /usr/share/pixmaps

	return
}

pkg_postinst() {
	chmod 755 /opt/davmail/davmail || die "Could not set file permissions on davmail file"

	return
}

pkg_postrm() {
	xdg-desktop-menu uninstall "${FILESDIR}"/abadonna-davmail.desktop || die "Could not de-register a menu item"

	return
}
