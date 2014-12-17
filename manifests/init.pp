# == Class: composer
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
#   include composer
#
#   class { 'composer':
#     'target_dir'   => '/usr/local/bin',
#     'user'         => 'root',
#     'command_name' => 'composer',
#     'auto_update'  => true
#   }
#
# === Authors
#
# Andreas Weber <code@andreas-weber.me>
#
# === Copyright
#
# Copyright 2014 Andreas Weber
#
class composer (
  $auto_update = false
)
{
  include composer::params

  $composer_path = "${::composer::params::target_dir}/composer"

  wget::fetch { 'composer-install':
    source      => $::composer::params::phar_location,
    destination => $composer_path,
    execuser    => $::composer::params::user,
  }

  exec { 'composer-fix-permissions':
    command => "chmod a+x composer",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $::composer::params::target_dir,
    user    => $::composer::params::user,
    unless  => "test -x ${composer_path}",
    require => Wget::Fetch['composer-install'],
  }

  if $auto_update {
    exec { 'composer-update':
      command     => "composer self-update",
      environment => [
        "COMPOSER_HOME=${::composer::params::target_dir}"
      ],
      path        => "/usr/bin:/bin:/usr/sbin:/sbin:${::composer::params::target_dir}",
      user        => $::composer::params::user,
      require     => Exec['composer-fix-permissions'],
    }
  }
}
