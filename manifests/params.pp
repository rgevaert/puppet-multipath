#
# Class multipath::params
class multipath::params {

  case $::operatingsystem {
    'RedHat', 'CentOS', 'ScientificLinux': {
      $packages = [ 'device-mapper-multipath' ]
      $service  = 'multipathd'
    }
    'Debian': {
      $packages = [ 'multipath-tools' ]
      $service  = 'multipath-tools'
    }
    default: {
      warning "multipath config management is currently not supported for OS ${::operatingsystem}"
    }
  }
}
