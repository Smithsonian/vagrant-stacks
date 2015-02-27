vagrant-stacks
==============

Vagrant launcher for STACKS 1.27 (http://creskolab.uoregon.edu/stacks)

This creates a VM on your computer running STACKS that can be used to run the command line tools and web interface of STACKS.

Requirements
------------
* Download and install VirtualBox (<https://www.virtualbox.org/>)
* Download and install Vagrant (<http://www.vagrantup.com/>)
* Download and install git if not installed (<http://git-scm.com/download>)

Installation
------------
```
 git clone https://github.com/Smithsonian/vagrant-stacks.git
 cd vagrant-stacks
 vagrant up
```

Use
---
* To access the stacks web interface
Point your browser at <http://localhost:8082/stacks>. You should see the Stacks webpage

* To use the stacks command line tools
Login to the VM command line `vagrant ssh`

* To setup a database use:
```
 mysql -u dbuser -pdbpass -e "CREATE DATABASE redseaexp_radtags"
 mysql -u dbuser -pdbpass redseaexp_radtags < /usr/share/stacks/sql/stacks.sql
```

Getting to files for analysis
------------
* By default only files in the conf folder in the vagrant-stacks folder will be accessible in the VM in the /vagrant directory
* To get to other files,
In Vagrantfile uncomment the line:
`#config.vm.synced_folder "/Users/", "/hostfiles"`
The example will take the folder /Users on the host computer and make it available as /hostfiles on the VM
* From the host use `vagrant reload` to use the new settings 

VM Configuration (optional)
------------
* Specify the number of CPUs to use with "v.cpus = 1"
* Specify the RAM the VM should use with "v.memory = 1024"
* From the host use `vagrant reload` to use the new settings

Stacks configuration used
-------------------
* Default mysql username= dbuser  password= dbpass
* Command line tools are installed in /usr/local/bin
* Web resources are in /usr/share/stacks

Vagrant basics
--------------

To access the command line of the vagrant VM type: `vagrant ssh`

To suspend the VM (save the current state) use: `vagrant suspend`

To reboot the VM with new configuration from the file Vagrantfile (e.g. RAM, CPUs)  : `vagrant reload`

To destroy the VM (**lose all data** not stored in /vagrant or /hostfiles if you configured that) use: `vagrant destory` 
