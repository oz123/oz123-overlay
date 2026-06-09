# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit meson gnome2-utils python-single-r1 xdg

DESCRIPTION="A simple sound recorder for the MATE desktop"
HOMEPAGE="https://github.com/mate-desktop/mate-sound-recorder"
SRC_URI="https://gitlab.com/oz123/mate-sound-recorder/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	dev-libs/glib:2
	media-libs/gstreamer:1.0[introspection]
	media-libs/gst-plugins-base:1.0[introspection]
	media-libs/gst-plugins-bad:1.0[introspection]
	x11-libs/gtk+:3[introspection]
	x11-themes/hicolor-icon-theme
"

BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_install() {
	meson_src_install
	python_fix_shebang "${ED}/usr/bin/${PN}"
	einstalldocs
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
