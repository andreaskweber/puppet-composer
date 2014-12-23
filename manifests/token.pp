# == Class: composer::token
#
# The composer::token class manages the auth file containing the oauth token
# needed for "unlimited" calls to github api.
#
# === Examples
#
#  class { 'composer::token':
#    home_dir => '/home/composer',
#    token => '9fXX9df645aa57da26f41bbcb9be73XXXXXXXX'
#  }
#
# === Authors
#
# Andreas Weber <code@andreas-weber.me>
#
# === Copyright
#
# Copyright 2014 Andreas Weber
#
class composer::token(
  $home_dir,
  $token
)
{
  include composer::params

  file { "${home_dir}/.composer":
    ensure  => 'directory',
    owner   => 'composer',
    group   => 'composer',
    mode    => '0755'
  }

  file { "${home_dir}/.composer/auth.json":
    ensure  => 'file',
    owner   => 'composer',
    group   => 'composer',
    mode    => '0644',
    source  => template($::composer::params::token_template),
    require => File["${home_dir}/.composer"]
  }
}
