# Run apt-get update when anything beneath /etc/apt/ changes
#taken from https://blog.kumina.nl/2010/11/puppet-tipstricks-running-apt-get-update-only-#when-needed/
exec { "apt-get update":
command => "/usr/bin/apt-get update",
onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

package {
	["build-essential","apache2","git","python","python-dev","python-setuptools", "python-pip"]:
	ensure => present,
	require => [Class["apt"], Exec["apt-get update"]],
	}

include apt

apt::builddep { ["python-imaging","python-lxml"]:
		require => Exec["apt-get update"],
 }
#The node.js from:http://theholyjava.wordpress.com/2013/06/21/installing-latest-node-js-and-npm-modules-with-puppet/
class prepare {
  apt::ppa { 'ppa:chris-lea/node.js': }
}
include prepare
 
package {'nodejs':
  ensure => present,
  require => Class['prepare'],
}
 
package {['grunt-cli','less']:
    ensure   => present,
    provider => 'npm',
    require  => Package['nodejs'],
}

package {"python-virtualenv":
	ensure => present,
	require => Package["python-pip", "python-setuptools"]
	}

package {"sphinx":
	ensure => present,
	require => Package["python-pip"],
	provider => pip
}

service {'apache2':
	ensure => running,
	enable => true,
	require => Package["apache2"]
	#subscribe => File["/etc/apache2/apache2.conf"]
}

#include postgresql
# class { 'postgresql':
#   charset => 'UTF8',
#   require => Class['apt'],
# }-> class { 'postgresql::server':

# config_hash => {
#     'ip_mask_deny_postgres_user' => '0.0.0.0/32',
#     'ip_mask_allow_all_users'    => '0.0.0.0/0',
#     'listen_addresses'           => '*',
#   },
# }

# class {'postgresql::client':
# 	package_ensure => present,
# 	require => Class['postgresql'],
# 	}
# class {'postgresql::python':
# 	package_ensure => present,
# 	require => Class['postgresql'],
# 	}

#postgresql::db { 'Oknessetdb':
#  user     => 'Oknessetdevuser',
#  password => 'devuserpassword', #change this after the setup 
#  require => Class["postgresql::server"]
#}

# from this part forward should be later seperated to a different manifest - a specifc one for Oknesset.

vcsrepo {"/home/hasadna":
	ensure => present,
	provider => git,
	source => "git@github.com:alonisser/Open-Knesset.git"	
}
 
#python::requirements { '/home/hasadna/Open-Knesset/requirements.txt':
#   virtualenv => '/home/hasadna/Open-Knesset',
# }

# python::virtualenv { '/home/hasadna/Open-Knesset':
#   ensure       => present,
#   requirements => '/home/hasadna/Open-Knesset/requirements.txt',
# }
