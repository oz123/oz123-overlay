# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 python3_6 )
inherit distutils-r1

DESCRIPTION="Python to native compiler"
HOMEPAGE="www.nuitka.net"
SRC_URI="http://nuitka.net/releases/${PN^}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
    =dev-python/appdirs-1.4.3
	>=dev-util/scons-3.0.1:0
	"

S=${WORKDIR}/${PN^}-${PV}
