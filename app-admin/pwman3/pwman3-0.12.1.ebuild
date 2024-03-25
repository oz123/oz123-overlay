# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )
PYTHON_REQ_USE="sqlite"
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 optfeature

DESCRIPTION="A lightweight password-manager with multiple database backends"
HOMEPAGE="https://pwman3.github.io/pwman3/"
SRC_URI="https://github.com/pwman3/pwman3/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cryptography-2.3[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.0[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/pexpect[${PYTHON_USEDEP}] )"

python_test() {
	python -m tests.test_pwman
}

pkg_postinst() {
	optfeature "Support for mongodb" dev-python/pymongo
	optfeature "Support for postgresql" dev-python/psycopg
	optfeature "Support for mysql" dev-python/pymysql
}

