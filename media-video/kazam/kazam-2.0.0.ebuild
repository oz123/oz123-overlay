# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 xdg

DESCRIPTION="Linux Screen Recorder, Broadcaster, Capture and OCR with AI"
HOMEPAGE="https://github.com/henrywoo/kazam"
SRC_URI="https://github.com/henrywoo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ocr"

RDEPEND="
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-plugins/gst-plugins-pulse
	media-sound/pulseaudio
	x11-misc/xdotool
	ocr? (
		app-text/tesseract
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pytesseract[${PYTHON_USEDEP}]
	)
"

BDEPEND="
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-build/cmake
"

DEPEND="${RDEPEND}"

python_prepare_all() {
	# Remove hiq dependency
	sed -i '/^hiq-python$/d' requirements.txt || die
	sed -i '/^import hiq$/d' setup.py || die

	# Create kazam/data directory if it doesn't exist
	mkdir -p kazam/data || die
	touch kazam/data/__init__.py || die

	# Fix package structure in setup.py if needed
	sed -i "s/'kazam.data',//" setup.py || die "Failed to remove kazam.data package"

	# Fix datadir path construction in bin/kazam for python-exec compatibility
	sed -i 's|datadir = curpath.split.*|datadir = "/usr/share/kazam/"|' bin/kazam || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	# Install desktop file
	if [[ -f data/kazam.desktop ]]; then
		domenu data/kazam.desktop
	fi

	# Install icons
	if [[ -d data/icons/scalable ]]; then
		insinto /usr/share/icons/hicolor/scalable/apps
		doins data/icons/scalable/*.svg
	fi

	# Install UI files
	if [[ -d data/ui ]]; then
		insinto /usr/share/kazam/ui
		doins data/ui/*.ui
	fi

	# Install sound files
	if [[ -d data/sounds ]]; then
		insinto /usr/share/kazam/sounds
		doins data/sounds/*.ogg
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "Kazam requires:"
	elog "- A compositing window manager or desktop environment"
	elog "- PulseAudio for audio recording"
	elog "- GStreamer plugins for video encoding"
	elog ""
	if use ocr; then
		elog "OCR support is enabled with Tesseract."
	else
		elog "Enable 'ocr' USE flag for optical character recognition features."
	fi
	elog ""
	elog "For live broadcasting, ensure you have proper network configuration"
	elog "and streaming service credentials configured."
}
