#!/usr/bin/env -S dumb-init /bin/sh

set -fue

PUID="${PUID:-"$(id -u nobody)"}"
PGID="${PGID:-"$(id -g nobody)"}"
chown $PUID:$PGID /build

if [ "${1:-""}" = "--run-shell" ];
then
  exec gosu $PUID:$PGID /bin/bash -i
fi

set +e
gosu $PUID:$PGID pkg2appimage $@
set -e

# this is running back under root on purpose
# as we don't own the buildout by default
[ -d "/buildout" -a -d "$PWD/out" ] && rsync -vrP $PWD/out/ /buildout/
rm -rvf ./*

