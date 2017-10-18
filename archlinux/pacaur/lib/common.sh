#!/hint/bash

_setup_workdir=false
setup_workdir() {
	[[ -z ${WORKDIR:-} ]] && WORKDIR=$(mktemp -d --tmpdir "${0##*/}.XXXXXXXXXX")
	_setup_workdir=true
	trap 'trap_abort' INT QUIT TERM HUP
	trap 'trap_exit' EXIT
}

cleanup() {
	if [[ -n ${WORKDIR:-} ]] && $_setup_workdir; then
		rm -rf "$WORKDIR"
	fi
	exit "${1:-0}"
}

abort() {
	error 'Aborting...'
	cleanup 255
}

trap_abort() {
	trap - EXIT INT QUIT TERM HUP
	abort
}

trap_exit() {
	local r=$?
	trap - EXIT INT QUIT TERM HUP
	cleanup $r
}
