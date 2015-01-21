# == Define: aw_composer::token
#
# This resource manages the auth file containing the oauth token
# needed for "unlimited" calls to github api.
#
# === Parameters
#
# [*home_dir*]
#   The users home directory.
#
# [*token*]
#   The users token.
#
# === Examples
#
#  aw_composer::token { 'some_username':
#    home_dir => '/home/some_username',
#    token => '9fXX9df645aa57da26f41bbcb9be73XXXXXXXX'
#  }
#
# === Authors
#
# Andreas Weber <code@andreas-weber.me>
#
# === Copyright
#
# Copyright 2015 Andreas Weber
#
define aw_composer::token (
  $home_dir,
  $token
)
{
  include aw_composer::params

  $user = $title

  file { "${home_dir}/.composer":
    ensure  => 'directory',
    owner   => $user,
    group   => $user,
    mode    => '0755'
  }

  file { "${home_dir}/.composer/auth.json":
    ensure  => 'file',
    owner   => $user,
    group   => $user,
    mode    => '0644',
    source  => template($::aw_composer::params::token_template),
    require => File["${home_dir}/.composer"]
  }
}
