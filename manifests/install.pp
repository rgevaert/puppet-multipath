# Class multipath::install
#
class multipath::install
{

  include multipath::params

  package { $multipath::params::packages:
      ensure  => installed,
  }

  if $::operatingsystem == 'Debian' {
    package { 'multipath-tools-boot':
      ensure => 'purged';
    }
  }
}
