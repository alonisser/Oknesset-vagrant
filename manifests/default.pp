exec { "apt-get update":
  path => "/usr/bin",
}

package {
	["build-essential","apache2",git","python","python-dev","python-setuptools", "python-pip"]:
	ensure => present,
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

exec { "apt-get update":
  path => "/usr/bin",
}
