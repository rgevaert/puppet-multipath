# Manage multipath service
class multipath (
  Integer $verbosity=2,
  Optional[Hash[String,String]] $aliases  = {}
) {
  class {
    'multipath::install':;
    'multipath::config':
        verbosity => $verbosity;
    'multipath::service':;
  }

  Class['multipath::install'] -> Class['multipath::config'] -> Class['multipath::service']

  create_resources('multipath::alias', $aliases, {})
}
