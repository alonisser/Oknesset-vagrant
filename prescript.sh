#!/bin/bash
echo 'provisioning librarian'
if [ ! -f ./modules/.installed ]
then
	echo 'installing libraria'
	gem install librarian-puppet
	librarian-puppet install
	touch modules/.installed
else
	echo 'librarian already installed once'
fi