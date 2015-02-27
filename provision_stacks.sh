# reference: http://creskolab.uoregon.edu/stacks/manual

CURRENTVERSION=1.27

# install prereqs
sudo apt-get update
sudo apt-get -y install make g++

# prep non-interactive mysql-server
echo mysql-server mysql-server/root_password password vagrant | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password vagrant | sudo debconf-set-selections

sudo apt-get -q -y install mysql-server php5 apache2
sudo apt-get -y install php-mdb2 php-mdb2-driver-mysql
sudo apt-get -y install libdbd-mysql-perl
sudo apt-get -y install samtools
sudo apt-get -y install libbam-dev
sudo apt-get -y install sparsehash
sudo apt-get -y install zlib1g-dev

# install STACKS
wget http://creskolab.uoregon.edu/stacks/source/stacks-$CURRENTVERSION.tar.gz
tar xfvz stacks-$CURRENTVERSION.tar.gz
cd stacks-$CURRENTVERSION
#./configure --enable-sparsehash --enable-bam --prefix=/home/vagrant/stacks
./configure
make
make install
sudo mv /usr/local/share/stacks /usr/share

# configure mysql
sudo cp /usr/share/stacks/sql/mysql.cnf.dist /usr/share/stacks/sql/mysql.cnf

mysqladmin -u root password vagrant
mysql -u root -pvagrant -e "GRANT ALL ON *.* TO 'dbuser'@'localhost' IDENTIFIED BY 'dbpass';"

# configure apache
sudo cp /vagrant/conf/stacks.conf /etc/apache2/conf-available
sudo a2enconf stacks
sudo service apache2 reload

# configure php
sudo cp /usr/share/stacks/php/constants.php.dist /usr/share/stacks/php/constants.php

#Setup for data exports
sudo chown www-data /usr/share/stacks/php/export

#Create DB
#mysql -u dbuser -pdbpass -e "CREATE DATABASE redseaexp_radtags"
#mysql -u dbuser -pdbpass redseaexp_radtags < /usr/share/stacks/sql/stacks.sql

