# Add a multipath::alias
define multipath::alias (
  String $wwid
  String $path_grouping_policy = '',
  String $path_selector = '',
  String $failback = '',
  String $no_path_retry = '',
  String $rr_min_io = '')
{

  $pgp = $path_grouping_policy ? {
    ''      => '',
    default =>  "set multipath[ alias = '${name}']/path_grouping_policy ${path_grouping_policy}",
  }

  $ps = $path_selector ? {
    ''      => '',
    default =>  "set multipath[ alias = '${name}']/path_selector ${path_selector}",
  }

  $fb = $failback ? {
    ''      => '',
    default =>  "set multipath[ alias = '${name}']/failback ${failback}",
  }

  $npr = $no_path_retry ? {
    ''      => '',
    default =>  "set multipath[ alias = '${name}']/no_path_retry ${no_path_retry}",
  }

  $rr = $rr_min_io ? {
    ''      => '',
    default =>  "set multipath[ alias = '${name}']/rr_min_io ${rr_min_io}",
  }

  $changes = [
      "set multipath[ alias = '${name}']/alias ${name}",
      "set multipath[ alias = '${name}']/wwid ${wwid}",
      $pgp,
      $ps,
      $fb,
      $npr,
      $rr,
  ]

  augeas { "alias_${name}":
    context => '/files/etc/multipath.conf/multipaths',
    changes => $changes,
    notify  => Class['multipath::service'],
  }
}
