echo asdf >> ~/.forever/asdf.log
rm ~/.forever/*.log

pkill node
pkill collectd

export NODE_HOME=$HOME/node
export PATH=$NODE_HOME/bin:$PATH

export COLLECTD_HOME=$HOME/arcus-collectd
export ARCUS_HUBBLE_HOME=$HOME/vendor/arcus-hubble
export ARCUS_HOME=$HOME/arcus

$ARCUS_HOME/scripts/clearun_arcus.sh
sleep 3
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-listener-5s.conf
sleep 7
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-arcus.conf
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-arcus-prefix.conf
$ARCUS_HUBBLE_HOME/start.sh
