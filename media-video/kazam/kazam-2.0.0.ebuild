# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 xdg

DESCRIPTION="Linux Screen Recorder, Broadcaster, Capture and OCR with AI in mind"
HOMEPAGE="https://github.com/henrywoo/kazam"
SRC_URI="https://github.com/henrywoo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio"

RDEPEND="
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	pulseaudio? ( dev-python/hiq[${PYTHON_USEDEP}] )
"

BDEPEND="
	dev-python/distutils-extra[${PYTHON_USEDEP}]
	sys-devel/cmake
"

DEPEND="${RDEPEND}"

python_prepare() {
	# Remove hiq dependency if pulseaudio USE flag is not set
	if ! use pulseaudio; then
		sed -i '/^hiq-python$/d' requirements.txt || die
		sed -i '/^import hiq$/d' setup.py || die
	fi

	distutils-r1_python_prepare
}

python_install_all() {
	distutils-r1_python_install_all

	# Install desktop file and icons
	insinto /usr/share/applications
	doins data/kazam.desktop || die

	# Install icons
	insinto /usr/share/icons/hicolor/scalable/apps
	doins data/icons/scalable/kazam.svg || die
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "Kazam requires the following to function properly:"
	elog "- A compositing window manager or desktop environment"
	elog "- GStreamer with appropriate plugins for video encoding"
	elog ""
	if use pulseaudio; then
		elog "PulseAudio support is enabled for enhanced audio features."
	else
		elog "PulseAudio support is disabled. Enable 'pulseaudio' USE flag"
		elog "for enhanced audio features and AI capabilities."
	fi
}
