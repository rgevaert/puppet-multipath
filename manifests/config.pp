# Configure multipath
#
class multipath::config($verbosity=2)
{
  file { '/etc/multipath.conf':
          owner => 'root',
          group => 'root',
  }

  augeas {
    'conf_comment':
      context => '/files/etc/multipath.conf',
      changes => [ "set #comment 'Managed with Puppet'" ];
    'verbosity':
      context => '/files/etc/multipath.conf',
      changes => [ "set defaults/verbosity ${verbosity}" ],
      notify  => Class['multipath::service'];
  }
}
