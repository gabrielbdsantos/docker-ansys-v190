#!/bin/bash

[ -z $1 ] && {
	echo "Installation path is missing."
	echo ""
	echo "USAGE: $0 INSTALL_DIR"
	usage
	exit 1
}

ANSYS_INSTALL_DIR=$(realpath $1)

docker run -it --rm \
	--env "LANG=$LANG" \
	--env "LC_ALL=C" \
	--env "DISPLAY=$DISPLAY" \
	--env "XAUTHORITY=$XAUTHORITY" \
	--env "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
	--volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
	--volume $XAUTHORITY:$XAUTHORITY \
	--volume $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
	--volume /opt/ansys/v190:/opt \
	--volume $HOME:$HOME \
	--workdir $ANSYS_INSTALL_DIR \
	local/centos7.3-ansys-v190 bash
