#!/bin/bash
set -e
echo 'provisioning librarian'
if [ ! -f /vagrant/modules/.installed ]
then
	echo 'installing librarian'
	gem install librarian-puppet
	sudo touch /vagrant/modules/.installed
else
	echo 'librarian already installed once'
fi
librarian-puppet install