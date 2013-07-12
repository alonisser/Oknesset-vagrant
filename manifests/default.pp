# Run apt-get update when anything beneath /etc/apt/ changes
#taken from https://blog.kumina.nl/2010/11/puppet-tipstricks-running-apt-get-update-only-when-needed/
exec { "apt-get update":
command => "/usr/bin/apt-get update",
onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

package {
	["build-essential","apache2","git","python","python-dev","python-setuptools", "python-pip"]:
	ensure => present,
	require => Exec["apt-get update"],
#	before=>Package["python-lxml","python-imaging"]
	}

#package {
#	["python-lxml","python-imaging"]:
#	ensure => present,
#}
class { 'apt':

		}
include apt

apt::builddep { ["python-imaging","python-lxml"]:
	require => Class['apt']	
 }

class {'nodejs':

}
include nodejs

package {"less":
	ensure => present,
	provider => 'npm',
	require => Package['npm'],

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
#service {'apache2':
#	ensure => running,
#	enable => true,
#	subscribe => File["/etc/apache2/apache2.conf"]
#}
# a comment 

#add postgresql
#add mkdir /oknesset
#add virtualenv
#add python::pip install from requirement
