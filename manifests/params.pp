# = Class: aw_composer::params
#
# This class defines default parameters used by the main module class composer.
#
# == Variables:
#
# Refer to composer class for the variables defined here.
#
# == Examples:
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes.
#
# === Authors
#
# Andreas Weber <code@andreas-weber.me>
#
# === Copyright
#
# Copyright 2015 Andreas Weber
#
class aw_composer::params {
  $phar_location  = 'https://getcomposer.org/composer.phar'
  $target_dir     = '/usr/local/bin'
  $user           = 'root'
  $token_template = 'aw_composer/auth.json.erb'
}
