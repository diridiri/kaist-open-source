echo asdf >> ~/.forever/asdf.log
rm ~/.forever/*.log

pkill node
pkill collectd

export COLLECTD_HOME=$HOME/arcus-collectd
export ARCUS_HUBBLE_HOME=$HOME/vendor/arcus-hubble
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-listener-5s.conf
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-arcus.conf
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-arcus-prefix.conf
$ARCUS_HUBBLE_HOME/start.sh
