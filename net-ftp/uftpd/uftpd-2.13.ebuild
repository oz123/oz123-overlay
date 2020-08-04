# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The no nonsense TFTP/FTP server"
HOMEPAGE="https://github.com/troglobit/uftpd"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/libite-1.5
	>=dev-libs/libuev-2.2"

PATCHES=(
       "${FILESDIR}/0001-patch-test.patch"
)

DEPEND="
	${RDEPEND}
	!net-misc/uftp
	!net-ftp/atftp
	!net-ftp/tftp-hpa
	test? (
		net-ftp/ftp
		net-ftp/tnftp
		sys-apps/busybox
	)"

src_test() {
	# can't run the tests in parallel since the order matters
	emake -j 1 check
}