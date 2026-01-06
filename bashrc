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
	local slot="${SLOT%%/*}"
	local dest="$PN"
	test "$slot" = 0 || dest="$PN:$slot"
	test -e "$ED/usr/share/doc/$PF" -a ! -e "$ED/usr/share/doc/$dest" || return
	einfo '/etc/portage/bashrc: Symlinking version-agnostic docdir'
	dosym "$PF" "/usr/share/doc/$dest"
}

bashrc_update_docdir() {
	local slot="${SLOT%%/*}"
	test "$slot" != 0 || return
	local link="$EROOT/usr/share/doc/$PN"
	test -h "$link" -o ! -e "$link" || return
	test -e "$EROOT/usr/share/doc/$PN:$slot" || return
	einfo '/etc/portage/bashrc: Update no-slot docdir symlink'
	test ! -h "$link" || rm "$link" || die
	ln -s "$PN:$slot" "$EROOT/usr/share/doc/$PN" || die
}

bashrc_cleanup_docdir() {
	local slot="${SLOT%%/*}"
	test "$slot" != 0 || return
	local link="$EROOT/usr/share/doc/$PN"
	test ! -h "$link" -o -e "$link" || rm "$link" || die
}

# NOTE: If a version with a symlink is installed, then removed, the symlink disappears,
# 	 	even if there's other valid versions that could supply the symlink.

post_pkg_preinst() {
	test -h "$EROOT/usr/share/doc/portage" && bashrc_symlink_docdir
	declare -F env-post_pkg_preinst > /dev/null && env-post_pkg_preinst
}

post_pkg_postinst() {
	test -h "$EROOT/usr/share/doc/portage" && bashrc_update_docdir
	declare -F env-post_pkg_postinst > /dev/null && env-post_pkg_postinst
}

post_pkg_postrm() {
	test -h "$EROOT/usr/share/doc/portage" && bashrc_cleanup_docdir
	declare -F env-post_pkg_postrm > /dev/null && env-post_pkg_postrm
}
