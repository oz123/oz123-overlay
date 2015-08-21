# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="X-tile is an application that allows you to select a number of
windows and tile them in different ways."
HOMEPAGE="http://www.giuspen.com/x-tile/"
SRC_URI="http://www.giuspen.com/software/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
dev-python/gconf-python
>=dev-python/pygtk-2.17"


