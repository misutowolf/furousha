# Gotta do this before RVM install, or it won't work.  Sigh.
stage {'preinstall':
  before => Stage['main']
}

class pre_install {

  exec {'apt-get update':
    command => '/usr/bin/apt-get -yq update',
  }

}

class { 'pre_install':
  stage => preinstall
}

class {'rvm': }

package { "libxml2":
  ensure => present,
  require => Exec['apt-get update'],
}

package { "nodejs":
  ensure => present,
  require => Exec['apt-get update']
}

package { "vim":
  ensure => present,
  require => Exec['apt-get update']
}

package { "screen":
  ensure => present,
  require => Exec['apt-get update']
}

rvm_system_ruby {
	'ruby-2.0.0-p247':
    ensure => present,
    default_use => true,
    require => Package['libxml2', 'nodejs']
}

rvm_gem {
  'puppet':
  name => 'puppet',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

rvm_gem {
  'rails':
  name => 'rails',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

rvm_gem {
  'rspec-rails':
  name => 'rspec-rails',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

# Capybara DSL for Rails testing
rvm_gem {
  'capybara':
  name => 'capybara',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

rvm_gem {
  'haml':
  name => 'haml',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

# Guard-LiveReload (for Rails)
rvm_gem {
  'guard-livereload':
  name => 'guard-livereload',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

# Devise (authentication)
rvm_gem {
  'devise':
  name => 'devise',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

# MailCatcher (for SMTP mocking (Devise can use this!))
rvm_gem {
  'mailctacher':
  name => 'mailcatcher',
  ruby_version => 'ruby-2.0.0-p247',
  ensure => latest,
  require => Rvm_system_ruby['ruby-2.0.0-p247']
}

# Unfortunately, this is the only way to fix things so 'bundle install' will work.
exec { 'fix_rvm_permissions':
  command => '/bin/chmod -R 775 /usr/local/rvm ; /bin/chown -R :rvm /usr/local/rvm',
  require => Rvm_gem["rails"]
}

# Must add default user (vagrant) to 'rvm' group for 'bundle install' also.
rvm::system_user { vagrant: ; }