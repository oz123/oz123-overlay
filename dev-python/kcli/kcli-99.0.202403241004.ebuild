# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )

DISTUTILS_USE_PEP517=no 
inherit distutils-r1 optfeature pypi

SRC_URI="$(pypi_wheel_url)"
S=${WORKDIR}


DESCRIPTION="A unified CLI interface for Libvirt, VMware and more."
HOMEPAGE="https://github.com/karmab/kcli"

LICENSE="GPL-3+"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

KEYWORDS="~amd64"

RDEPEND="
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/libvirt-python:=[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

src_unpack() {
	unzip "${DISTDIR}/${A}" || die
}

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${P}-py3-none-any.whl"
}

pkg_postinst() {
	optfeature_header "kcli supports many virtualization backends"
	optfeature "for aws" "dev-python/boto3"
	optfeature "for kubevirt" "sys-cluster/kubectl"
	optfeature "for vsphere" "dev-python/pyvmomi dev-python/cryptography"
}
