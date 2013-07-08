Oknesset-vagrant
================

A vagrantfile + puppet scripts + some more setup scripts to set a virtual ubunto linux machine for [Okneeset](https://github.com/hasadna/Open-Knesset) hacking


basically:

1. Install [vagrant](http://www.vagrantup.com/)
2. Install [Virtualbox](https://www.virtualbox.org/wiki/Download_Old_Builds_4_2) . notice you need to install version 4.2.10 since the 4.2.14/6 has some bug with vagrant. 
3.move to the command line and:


   git clone git@github.com:alonisser/Oknesset-vagrant.git
   cd oknesset-vagrant
   vagrant up

4. ```vagrant up``` would download the virtual machine (ubunto linux precise pangolin) and set it up to oknesset dev with a puppet script. this should take some time and some linux bells and whistle.

5.```vagrant ssh``` to log into the virtual machine

6.```vagrant halt``` (after ```exit```) to shut it down (You can probably look into the vagrant docs to learn about all vagrant commands). Don't worry, next time you run vagrant up, It would need to do all the downloading and provisioning and it would be much quicker.



More resources (besides the [docs](http://docs.vagrantup.com/v2/)):

A [hebrew Blog post](http://4p-tech.co.il/blog/?p=1741) I wrote about using vagrant.

Contributing:

quite a lot to do here, look at the github Issue tracker

Technology:

using a puppet script in ./manifests for provisoning.

License: [MIT](http://opensource.org/licenses/MIT) (do anything with this)