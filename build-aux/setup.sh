#!/bin/bash
export PATH=/opt/gridlabd/bin:/usr/bin:/bin:/usr/sbin:/sbin

SYSTEM=$(uname -s)
SETUP=${0/.sh/-$SYSTEM.sh}
if [ ! -f "$SETUP" ]; then
	${0/.sh/-manual.sh} $*
    exit 1
fi
$SETUP $*
