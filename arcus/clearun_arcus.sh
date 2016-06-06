export COLLECTD_HOME=$HOME/arcus-collectd
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-listener-5s.conf
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-arcus.conf
$COLLECTD_HOME/sbin/collectd -C $COLLECTD_HOME/etc/collectd-arcus-prefix.conf
