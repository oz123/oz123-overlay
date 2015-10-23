# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils fdo-mime multilib versionator

DESCRIPTION="Mongodb - Binary files from mongodb.org"
HOMEPAGE="https://mongodb.org/"
MY_PV=$(replace_version_separator 3 '-')

SRC_URI="x86?   ( https://fastdl.mongodb.org/linux/mongodb-linux-i686-${PV}.tgz )
		 amd64? ( https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${PV}.tgz )"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="splitdebug strip"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	exeinto /usr/local/bin/
	doexe mongodb-linux-x86_64-3.0.7/bin/bsondump
	doexe mongodb-linux-x86_64-3.0.7/bin/mongo{,d,dump,export,files,import,oplog,perf,restore,s,stat,top}
	newinitd "${FILESDIR}/${PN}.initd-r2" ${PN}
	newconfd "${FILESDIR}/${PN}.confd-r2" ${PN}
	newinitd "${FILESDIR}/${PN/db/s}.initd-r2" ${PN/db/s}
	newconfd "${FILESDIR}/${PN/db/s}.confd-r2" ${PN/db/s}

	insinto /etc
	newins "${FILESDIR}/${PN}.conf-r3" ${PN}.conf
	newins "${FILESDIR}/${PN/db/s}.conf-r2" ${PN/db/s}.conf
	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${PN}.logrotate" ${PN}
}

pkg_postinst() {
	elog "This ebuild does not replace MongoDB build from source."
	elog "It can co-exist with other mongodb installations you have."
	elog "The default ports of the server are unchange though, so "
	elog "you can have both running! Check all configuration files!"
}
