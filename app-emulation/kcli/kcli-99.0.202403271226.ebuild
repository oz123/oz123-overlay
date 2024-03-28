# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

SRC_URI="https://files.pythonhosted.org/packages/f4/1e/b1142e1551d58138066c0b929c5bef2078485fda4a43e6365fef85605a8c/kcli-99.0.202403271226.tar.gz -> ${P}.tar.gz"

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

S=${WORKDIR}/${P}

pkg_postinst() {
	optfeature_header "kcli supports many virtualization backends"
	optfeature "for aws" "dev-python/boto3"
	optfeature "for kubevirt" "sys-cluster/kubectl"
	optfeature "for vsphere" "dev-python/pyvmomi dev-python/cryptography"
}
