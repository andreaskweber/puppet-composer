# == Class: aw_composer
#
# This module manages the installation of Composer.
#
# === Parameters
#
# [*auto_update*]
#   Whether to run `composer self-update`.
#
# === Examples
#
#   include aw_composer
#
#   class { 'aw_composer':
#     'auto_update'  => true
#   }
#
# === Authors
#
# Andreas Weber <code@andreas-weber.me>
#
# === Copyright
#
# Copyright 2015 Andreas Weber
#
class aw_composer (
  $auto_update = false
)
{
  include aw_composer::params

  $composer_binary = "${::aw_composer::params::target_dir}/composer"

  exec{ 'composer-install':
    command => "wget -q ${::aw_composer::params::phar_location} -O ${composer_binary}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    creates => $composer_binary
  }

  exec { 'composer-fix-permissions':
    command => "chmod a+x composer",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $::aw_composer::params::target_dir,
    user    => $::aw_composer::params::user,
    unless  => "test -x ${composer_binary}",
    require => Exec['composer-install']
  }

  if $auto_update {
    exec { 'composer-update':
      command     => "composer self-update",
      environment => [
        "COMPOSER_HOME=${::aw_composer::params::target_dir}"
      ],
      path        => "/usr/bin:/bin:/usr/sbin:/sbin:${::aw_composer::params::target_dir}",
      user        => $::aw_composer::params::user,
      require     => Exec['composer-fix-permissions'],
    }
  }
}
