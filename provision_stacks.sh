# reference: http://creskolab.uoregon.edu/stacks/manual

CURRENTVERSION=1.34

# install prereqs
sudo apt-get update
sudo apt-get -y install make g++

# prep non-interactive mysql-server
echo mysql-server mysql-server/root_password password vagrant | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password vagrant | sudo debconf-set-selections

sudo apt-get -q -y install mysql-server-5.6 php5 apache2
sudo apt-get -y install php-mdb2 php-mdb2-driver-mysql
sudo apt-get -y install libdbd-mysql-perl
#sudo apt-get -y install samtools
#sudo apt-get -y install libbam-dev
#sudo apt-get -y install sparsehash
sudo apt-get -y install zlib1g-dev
sudo apt-get -y install libncurses5-dev

# install samtools 0.1.19
cd /home/vagrant
wget http://downloads.sourceforge.net/project/samtools/samtools/0.1.19/samtools-0.1.19.tar.bz2
tar xf samtools-0.1.19.tar.bz2
cd samtools-0.1.19
make
cp *.h /usr/local/include/
cp *.a /usr/lib
 
# install sparsehash
cd /home/vagrant
wget -q https://sparsehash.googlecode.com/files/sparsehash-2.0.2.tar.gz
tar xf sparsehash-2.0.2.tar.gz
cd sparsehash-2.0.2
./configure
make
make install

# install STACKS
cd /home/vagrant
wget -q http://creskolab.uoregon.edu/stacks/source/stacks-$CURRENTVERSION.tar.gz
tar xfvz stacks-$CURRENTVERSION.tar.gz
cd stacks-$CURRENTVERSION
./configure --enable-sparsehash --enable-bam
make
make install
sudo mv /usr/local/share/stacks /usr/share
cd /home/vagrant

# configure mysql
sudo cp /usr/share/stacks/sql/mysql.cnf.dist /usr/share/stacks/sql/mysql.cnf

#mysqladmin -u root password vagrant
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

