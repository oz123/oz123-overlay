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
	insinto /usr/local/
	doins -r mongodb-linux-x86_64-3.0.7/bin
}

