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
