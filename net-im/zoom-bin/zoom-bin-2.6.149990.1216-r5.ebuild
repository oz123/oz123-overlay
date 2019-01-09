# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

MY_PN=zoom

DESCRIPTION="Video conferencing and web conferencing service"
HOMEPAGE="https://zoom.us"
BASE_SERVER_URI="https://zoom.us"

SRC_URI="
	amd64? ( ${BASE_SERVER_URI}/client/${PV}/${MY_PN}_x86_64.tar.xz -> ${P}_x86_64.tar.xz )
"

LICENSE="zoom"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

IUSE="pulseaudio gstreamer"

DEPEND=""
RDEPEND="${DEPEND}
	pulseaudio? ( media-sound/pulseaudio )
	gstreamer? ( media-libs/gst-plugins-base )
	dev-db/unixODBC
	dev-libs/glib
	dev-libs/nss
	dev-libs/libxslt
	media-libs/fontconfig
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	media-libs/mesa
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXi
	x11-libs/libXrender
	"

S=${WORKDIR}

src_install() {
	make_wrapper "${PN}" /opt/zoom/zoom /opt/zoom /opt/zoom
	newicon -s 96 "${FILESDIR}/Zoom.png" zoom.png
	insinto "/opt/"
	doins -r "${S}/"*
	fperms +x /opt/zoom/zoom
	make_desktop_entry zoom-bin zoom-bin "/usr/share/icons/hicolor/96x96/apps/zoom.png"
}
