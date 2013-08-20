Oknesset-vagrant
================

A vagrantfile + puppet scripts + some more setup scripts to set a virtual ubunto linux machine for [Okneeset](https://github.com/hasadna/Open-Knesset) hacking


##for starters (usage):

1. Install [vagrant](http://www.vagrantup.com/)
2. you should have a "hasadna" folder in the same folder you are goint to do ```git clone```
3. Install [Virtualbox](https://www.virtualbox.org/wiki/Download_Old_Builds_4_2) . notice you need to install version 4.2.10/16 since the 4.2.14 has some bug with vagrant. 
3.move to the command line and:


    ```bash
    git clone git@github.com:alonisser/Oknesset-vagrant.git  
    cd oknesset-vagrant  
    git submodule update --init  
    vagrant up
    ```

4. ```vagrant up``` would download the virtual machine (ubunto linux precise pangolin) and set it up to oknesset dev with a puppet script. this should take some time (15-20 minutes for the first time!) and some linux bells and whistle.

Notice, this might end with some failure message. Most of the time you can just ignore it. If some of the dependencies don't work when you try to run. you can just ```apt-get --fix-missing``` after the ```vagrant ssh```.

5.```vagrant ssh``` to log into the virtual machine

6.```vagrant halt``` (after ```exit```) to shut it down (You can probably look into the vagrant docs to learn about all vagrant commands). Don't worry, next time you run vagrant up, It would need to do all the downloading and provisioning and it would be much quicker.



##More resources (besides the [docs](http://docs.vagrantup.com/v2/)):

A [hebrew Blog post](http://4p-tech.co.il/blog/?p=1741) I wrote about using vagrant.

##tweaks and bugs
This vagrantfiles runs (and provisions) a **Headless** linux virtual machine. "headless" as a zombie, no GUI. If you want/need to work with the virtual machine gui (and take all the performance hit) you need to uncomment the following lines in the vagrantfile:

    '''ruby
       config.vm.provider :virtualbox do |vb|
    #  # Don't boot with headless mode
      vb.gui = true
    #
    #   # Use VBoxManage to customize the VM. For example to change memory:
    #   vb.customize ["modifyvm", :id, "--memory", "1024"]
    	end
    '''ruby
Don't uncomment the vb.customize unless you mean to change something there
for common vagrant problem look at the Vagrant github [wiki page](https://github.com/mitchellh/vagrant/wiki/%60vagrant-up%60-hangs-at-%22Waiting-for-VM-to-boot.-This-can-take-a-few-minutes%22)
More problems in my [gist](https://gist.github.com/alonisser/6225223)
##Technology:

using vagrant to download setup and access a virtual headless linux machine.  

using a standalone (without a puppetmaster) [puppet](https://puppetlabs.com/) script in ./manifests for provisoning.

##Contributing:

Quite a lot to do here, look at the github Issue tracker.

I recommend to install the **[puppet command line tool](http://docs.puppetlabs.com/guides/installation.html)** on the **host** machine to be able to check the puppet script

##License:
[MIT](http://opensource.org/licenses/MIT) (do anything with this)
