# Manage multipath service
class multipath (Integer $verbosity=2)
{
  class {
    'multipath::install':;
    'multipath::config':
        verbosity => $verbosity;
    'multipath::service':;
  }

  Class['multipath::install'] -> Class['multipath::config'] -> Class['multipath::service']
}
