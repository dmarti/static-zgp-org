#!/bin/sh

set -e
set -x

DOCROOT=/var/www/static
SITE=004-static-zgp-org.conf

SCRIPT=$(readlink -f "$0")
cd $(dirname "$SCRIPT")

cp $SITE /etc/apache2/sites-available
a2ensite $SITE
service apache2 reload

mkdir -p $DOCROOT/linklog
chown root.www $DOCROOT/linklog
chmod g+rwx $DOCROOT/linklog
cp index.html $DOCROOT

cp mirror-linklog.service mirror-linklog.timer /etc/systemd/system
systemctl daemon-reload
systemctl enable mirror-linklog.timer
systemctl start mirror-linklog.timer

