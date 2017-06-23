#!/bin/sh

set -e
set -x

HOST=static.zgp.org
EXCLUDES="--exclude .git"

rsync -rpt $EXCLUDES . $HOST:static
ssh $HOST sudo static/setup.sh
ssh $HOST rm -rf static

