#!/bin/bash

yum -y update
yum install -y net-tools.x86_64 vim-enhanced zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel \
                readline-devel tk-devel gcc make libffi-devel wget epel-release git tree
yum install -y python-pip

mkdir -p /opt/module /opt/software
SOFTWARE_HOME="/opt/software"
INSTALL_HOME="/opt/module"


# Python env
cd ${SOFTWARE_HOME} && wget 'https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz'
tar -zxvf Python-3.7.6.tgz -C ${INSTALL_HOME}
cd "${INSTALL_HOME}/Python-3.7.6" && ./configure prefix=/usr/local/python3 && make && make install
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python3
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip3

# Spark env
cd ${SOFTWARE_HOME} && wget 'http://apache.communilink.net/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz'
tar -zxvf spark-2.4.7-bin-hadoop2.7.tgz -C ${INSTALL_HOME}

# Java env
cd ${SOFTWARE_HOME} && wget 'https://github.com/leon-zhu/Centos7_Conf/raw/master/software/jdk-8u261-linux-x64.tar.gz'
tar -zxvf jdk-8u261-linux-x64.tar.gz -C ${INSTALL_HOME}

echo 'export JAVA_HOME=/opt/module/jdk1.8.0_261/' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile
source /etc/profile
ln -s /opt/module/jdk1.8.0_261/bin//java /usr/bin/java


# TimeZone
echo 'TZ='Asia/Shanghai'; export TZ' >> ~/.profile
source ~/.profile







