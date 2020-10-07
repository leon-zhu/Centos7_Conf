#!/bin/bash

yum -y update
yum install -y net-tools.x86_64 vim-enhanced zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel \
                readline-devel tk-devel gcc make libffi-devel wget epel-release git tree lsof nmap p7zip
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

# hadoop
cd ${SOFTWARE_HOME} && wget 'http://ftp.mirror.tw/pub/apache/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz'
tar -zxvf hadoop-2.9.2.tar.gz -C ${INSTALL_HOME}
echo 'export HADOOP_HOME=/opt/module/hadoop-2.9.2' >> /etc/profile
echo 'export PATH=$PATH:${HADOOP_HOME}/bin' >> /etc/profile
echo 'export PATH=$PATH:${HADOOP_HOME}/sbin' >> /etc/profile
source /etc/profile

# Spark env
cd ${SOFTWARE_HOME} && wget 'http://apache.communilink.net/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz'
tar -zxvf spark-2.4.7-bin-hadoop2.7.tgz -C ${INSTALL_HOME}

# Java env
cd ${SOFTWARE_HOME} && wget 'https://github.com/leon-zhu/Centos7_Conf/raw/master/software/jdk-8u261-linux-x64.tar.gz'
tar -zxvf jdk-8u261-linux-x64.tar.gz -C ${INSTALL_HOME}

echo 'export JAVA_HOME=/opt/module/jdk1.8.0_261' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile
source /etc/profile
ln -s /opt/module/jdk1.8.0_261/bin//java /usr/bin/java

# Redis 6.0
# 升级gcc 4.8.5 -> 9.3.1 (方便编译redis 6.0)
yum -y install centos-release-scl &&
yum -y install devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-binutils &&
scl enable devtoolset-9 bash

cd ${SOFTWARE_HOME} && wget 'http://download.redis.io/releases/redis-6.0.8.tar.gz'
tar -zxvf redis-6.0.8.tar.gz -C ${INSTALL_HOME}
make && make install PREFIX=/usr/local/redis
echo 'export PATH=/usr/local/redis/bin:$PATH' >> /etc/profile
source /etc/profile

# TimeZone
echo 'TZ='Asia/Shanghai'; export TZ' >> ~/.profile
source ~/.profile

# close firewalld
systemctl stop firewalld.service
systemctl disable firewalld.service







