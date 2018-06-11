# Add a multipath::device
# vendor, e.g. DELL
define multipath::device (
  String $vendor,
  String $path_grouping_policy = '',
  String $path_selector = '',
  String $failback = '',
  String $features = '',
  String $no_path_retry = '',
  String $rr_min_io = '',
  String $hardware_handler = '',
  String $path_checker = '',
  String $prio = '',
)
{
  $product = $name

  $pgp = $path_grouping_policy ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/path_grouping_policy ${path_grouping_policy}",
  }

  $ps = $path_selector ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/path_selector '${path_selector}'",
  }

  $fb = $failback ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/failback ${failback}",
  }

  $f = $features ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/features '${features}'",
  }

  $rr = $rr_min_io ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/rr_min_io ${rr_min_io}",
  }

  $hh = $hardware_handler ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/hardware_handler '${hardware_handler}'",
  }

  $pc = $path_checker ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/path_checker ${path_checker}",
  }

  $p = $prio ? {
    ''      => '',
    default =>  "set device[ vendor = '${vendor}']/prio ${prio}",
  }

  $changes = [
    "set device[ vendor = '${vendor}']/vendor ${vendor}",
    "set device[ vendor = '${vendor}']/product ${product}",
    $pgp,
    $ps,
    $fb,
    $f,
    $rr,
    $hh,
    $pc,
    $p,
  ]

  augeas { "device_${product}":
    context => '/files/etc/multipath.conf/devices',
    changes => $changes,
    notify  => Class['multipath::service'],
  }
}
