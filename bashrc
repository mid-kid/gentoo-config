# Packages for which the ulimit approach doesn't work, because they reserve a lot
# of virtual memory despite not using it.
noulimit=(
	# v8 engine allocates 8GB virtual memory (kSandboxMinimumReservationSize)
	dev-qt/qtwebengine

	# Linker runs out of virtual memory even at j1 without lto
	sys-libs/glibc
)

if ! has "$CATEGORY/$PN" "${noulimit[@]}"; then
	# Limit portage memory use to 8GB
	ulimit -v 8388608
fi
