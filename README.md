vagrant-stacks
==============

Vagrant launcher for STACKS 1.0.8 (http://creskolab.uoregon.edu/stacks)

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
===
Point your browser at <http://localhost:8082/>
You should see: "**It works!...**"

To access the command line of the vagrant VM type: `vagrant ssh`

To use data files from you computer in the vagrant VM move them into the vagrant-stacks folder and the files will be accessible in the /vagrant folder in the VM

To suspend the VM (save the current state) use: `vagrant suspend`

To destory the VM (lose all data not stored in /vagrant) use: `vagrant destory` 
