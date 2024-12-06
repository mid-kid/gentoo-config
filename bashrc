{
	# Packages for which the ulimit approach doesn't work, because they reserve a lot
	# of virtual memory despite not using it.
	local noulimit=(
		# v8 engine allocates 8GB virtual memory (kSandboxMinimumReservationSize)
		dev-qt/qtwebengine

		# Linker runs out of virtual memory even at j1 without lto
		sys-libs/glibc
	)

	# Some packages require more memory during link, even at -flto=1
	local max_16gb=(
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
