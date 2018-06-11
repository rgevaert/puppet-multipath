# Class multipath::service
#
class multipath::service
{
  include multipath::params

  service {
      $multipath::params::service:
        ensure     => 'running',
        hasrestart => true,
        hasstatus  => false,
        enable     => true,
        pattern    => 'multipathd',
    }
}
