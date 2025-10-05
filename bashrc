{
	# Packages for which the ulimit approach doesn't work, because they reserve a lot
	# of virtual memory despite not using it.
	local noulimit=(
		# v8 engine allocates 8GB virtual memory (kSandboxMinimumReservationSize)
		dev-qt/qtwebengine

		# Could not allocate compressed class space: 1073741824 bytes
		dev-java/openjdk
	)

	# Some packages require more memory during link, even at -flto=1
	local max_16gb=(
		sys-libs/glibc
		net-im/telegram-desktop
		sys-kernel/gentoo-kernel  # Under some configurations...
	)

	if has "$CATEGORY/$PN" "${noulimit[@]}"; then
		: # No limit
	elif has "$CATEGORY/$PN" "${max_16gb[@]}"; then
		# Limit portage memory use to 16GB
		ulimit -v 16777216
	else
		# Limit portage memory use to 8GB
		ulimit -v 8388608
	fi
}

bashrc_symlink_docdir() {
	local dest="$PN"
	test "$SLOT" = 0 || dest="$PN:$SLOT"
	test -e "$ED/usr/share/doc/$P" -a ! -e "$ED/usr/share/doc/$dest" || return
	einfo '/etc/portage/bashrc: Symlinking version-agnostic docdir'
	dosym "$P" "/usr/share/doc/$dest"
}

post_pkg_preinst() {
	#bashrc_symlink_docdir
	declare -F env-post_pkg_preinst > /dev/null && env-post_pkg_preinst
}
