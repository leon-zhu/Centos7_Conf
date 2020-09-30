#!/bin/bash

# 获取输入参数个数
count=$#
if [ ${count} == 0 ]
then
  echo "no args"
  exit
fi

# 获取文件名称
p1=$1
fname=`basename $p1`
echo "fname: ${fname}"

# 获取上级目录的绝对路径
pdir=`cd -P $(dirname $p1); pwd`
echo "pdir: ${pdir}"

# 获取当前用户
user=`whoami`
echo "current user: ${user}"

# 循环同步文件
for each_host in "home-work01" "home-work02" "home-work03"
do
    hostname=`hostname`
    if [ ${each_host} == ${hostname} ]
    then
        continue
    fi

    echo "----------------${each_host}--------------------"
    # recursive verbose symlink
    rsync -rvl ${pdir}/${fname} ${user}@${each_host}:${pdir}
done