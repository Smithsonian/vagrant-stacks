# reference: http://creskolab.uoregon.edu/stacks/manual

# install prereqs
sudo apt-get update
sudo apt-get -y install make g++
sudo apt-get -q -y install mysql-server php5 apache2
mysqladmin -u root password vagrant
sudo apt-get -y install php-mdb2 php-mdb2-driver-mysql
sudo apt-get -y install libdbd-mysql-perl
sudo apt-get -y install samtools
sudo apt-get -y install libbam-dev
sudo apt-get -y install sparsehash

# install STACKS
wget http://creskolab.uoregon.edu/stacks/source/stacks-1.08.tar.gz
tar xfvz stacks-1.08.tar.gz
cd stacks-1.08
#./configure
#./configure --enable-sparsehash --enable-bam --prefix=/home/vagrant/stacks
export STACKSPATH=/home/vagrant/stacks
./configure --prefix=$STACKSPATH
make
make install

# configure mysql
cd $STACKSPATH/share/mysql
cp mysql.cnf.dist mysql.cnf
cd ~

mysql -u root -p -e "GRANT ALL ON *.* TO 'vagrant'@'localhost' IDENTIFIED BY 'vagrant';"

# configure apache
sudo cp /vagrant/conf/stacks.conf /etc/apache2/conf.d/
sudo apachectl restart

# configure php
cp $STACKSPATH/share/stacks/php/constants.php.dist $STACKSPATH/share/stacks/php/constants.php

chown www $STACKSPATH/share/stacks/php/export

