# Packages for which the ulimit approach doesn't work, because they reserve a lot
# of virtual memory despite not using it.
noulimit=(
	dev-qt/qtwebengine
)

if ! has "$CATEGORY/$PN" "${noulimit[@]}"; then
	# Limit portage memory use to 8GB
	ulimit -v 8388608
fi
